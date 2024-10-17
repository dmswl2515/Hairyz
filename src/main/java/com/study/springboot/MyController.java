package com.study.springboot;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dao.IOrderProductDao;
import com.study.springboot.dao.IOrdersDao;
import com.study.springboot.dao.IPetListDao;
import com.study.springboot.dao.IProductReviewDao;
import com.study.springboot.dao.IReviewReplyDao;
import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrderProductDto;
import com.study.springboot.dto.OrdersDto;
import com.study.springboot.dto.PDto;
import com.study.springboot.dto.PageDto;
import com.study.springboot.dto.PetListDto;
import com.study.springboot.dto.ProductReviewDto;
import com.study.springboot.service.PService;
import com.study.springboot.service.SearchService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class MyController {
	
	@Autowired
	IMemberDao memberDao;
	
	@Autowired
	IPetListDao pteListDao;
	
	@Autowired
	IOrderProductDao orderProductDao;
	
	@Autowired
	IProductReviewDao reviewDao;
	
	@Autowired
    private ServletContext servletContext;
	
	@Autowired
	IReviewReplyDao reviewReplyDao;
	
	@Autowired
	IOrdersDao ordersDao;
	
	@Autowired
	SearchService sService;
	
	@Autowired
	PService pService;
	
	@Value("${KAKAO-KEY}")
	private String KAKAO_KEY;

    @RequestMapping("/")
    public String root() throws Exception{
        return "redirect:main_view.do";
    }
 
    @RequestMapping("/main_view.do")
    public String main(Model model) {
    	
    	model.addAttribute("kakaoKey", KAKAO_KEY);
    	
        return "main_view";                 
    }
    
    //내 프로필 화면
    @RequestMapping("/myProfile_view.do")
    public String myProfileView(HttpServletRequest request, Model model, HttpSession session) {
    	
    	String mdId = (String) session.getAttribute("userId");
		MemberDto dto = memberDao.selectMember(mdId);
		model.addAttribute("profile_view", dto);
		model.addAttribute("kakaoKey", KAKAO_KEY);
        return "myProfile_view";
    }
    
    // 회원정보 수정 화면
    @RequestMapping("/editProfile.do")
    public String editProfile(Model model, HttpServletRequest request) {
    	
    	String mdId = request.getParameter("id");
		MemberDto dto = memberDao.selectMember(mdId);
		model.addAttribute("editProfile", dto);
		model.addAttribute("kakaoKey", KAKAO_KEY);
        return "editProfile";
    }
    
    // 회원정보 수정 및 내 프로필 이동
    @RequestMapping("/updateProfile.do")
    public String updateProfile(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws ServletException, IOException {
    	
    	String originalName = null;
		String saveFileName = null;
		File serverPatheFullName = null;
		
		try
		{
			// 서버의 물리적경로 가져오기
			String path = ResourceUtils.getFile(servletContext.getRealPath("/upload/")).toPath().toString();

			/*
			 * 파일업로드 위한 MultipartHttpServletRequest객체 생성 객체 생성과 동시에 파일업로드 완료됨. 나머지 폼값은
			 * Multipart가 통째로 받아서 처리한다.
			 */
			MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;

			// 업로드폼의 file속성 필드의 이름을 모두 읽음
			Iterator<String> itr = mhsr.getFileNames();

			MultipartFile mfile = null;
			String fileName = "";

			// 폼값받기 : 제목
			String title = mhsr.getParameter("memberImage");

			// 업로드폼의 file속성의 필드의 갯수만큼 반복
			while (itr.hasNext())
			{

				// userfile1, userfile2....출력됨
				fileName = (String) itr.next();
				// System.out.println(fileName);

				// 서버로 업로드된 임시파일명 가져옴
				mfile = mhsr.getFile(fileName);
				// System.out.println(mfile);//CommonsMultipartFile@1366c0b 형태임

				// 한글깨짐방지 처리 후 업로드된 파일명을 가져온다.
				originalName =
						// mfile.getOriginalFilename();
						new String(mfile.getOriginalFilename().getBytes(), "UTF-8"); // Linux

				// 파일명이 공백이라면 while문의 처음으로 돌아간다.
				if ("".equals(originalName))
				{
					continue;
				}

				saveFileName = getUuid() + "." + originalName;

				// 설정한 경로에 파일저장
				serverPatheFullName = new File(path + File.separator + originalName);

				// 업로드한 파일을 지정한 파일에 저장한다.
				mfile.transferTo(serverPatheFullName);

			}
		} catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
		} catch (IllegalStateException e)
		{
			e.printStackTrace();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		
		String id = request.getParameter("id");
		String path = null;
		String nickName = request.getParameter("nickName");
		String phone = request.getParameter("phone");
		String zipcode = request.getParameter("zipcode");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		
		if(serverPatheFullName != null) {
			path = serverPatheFullName.getPath();
			memberDao.updateProfile(id, nickName, phone, zipcode, addr1, addr2, originalName, saveFileName, path);
			
		}else {
			
			memberDao.updateProfile2(id, nickName, phone, zipcode, addr1, addr2);
		}
    	
    	
    	session.setAttribute("userNickname", nickName); // 세션 닉네임 업데이트
    	
    	MemberDto dto = memberDao.selectMember(id);
    	model.addAttribute("profile_view", dto);
    	
        return "myProfile_view";
    }
    
    // 비밀번호변경 화면
    @RequestMapping("/editPassword.do")
    public String editPassword(Model model, HttpServletRequest request) {
    	
    	String mdId = request.getParameter("id");
    	
		model.addAttribute("editPassword", mdId);
		
        return "editPassword";
    }
    
    // 비밀번호 변경 및 체크, 내 프로필 화면 이동
    @RequestMapping("/updatePassword.do")
    public String updatePassword(Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String mdId = request.getParameter("id");
    	String pw = request.getParameter("password");
    	String nPw = request.getParameter("newPassword");
    	
    	MemberDto dto = memberDao.selectMember(mdId);
    	
    	if(dto.getMb_pw().equals(pw)) {
    		memberDao.updatePw(mdId, nPw);
    	}else {
    		
    		response.setContentType("text/html; charset=UTF-8");
    	    PrintWriter writer = response.getWriter();
    		
    	    writer.println("<html><head></head><body>");
			writer.println("<script language=\"javascript\">");
			writer.println("alert(\"기존 비밀번호가 일치하지 않습니다. 다시 입력해 주세요.\");");
			writer.println("history.back();");
			writer.println("</script>");
			writer.println("</body></html>");
			writer.close();

	        return null;
    		
    	}
    	
    	dto = memberDao.selectMember(mdId);
    	model.addAttribute("profile_view", dto);
		
        return "myProfile_view";
    }
    
	// 회원탈퇴 화면
	@RequestMapping("/accountDelete.do")
	public String accountDelete(Model model, HttpServletRequest request)
	{

		String mdId = request.getParameter("id");

		model.addAttribute("accountDelete", mdId);

		return "account_delete";
	}

	// 회원탈퇴
	@RequestMapping("/deleteAccount.do")
	public String deleteAccount(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException
	{

		String mdId = request.getParameter("id");
		String pw = request.getParameter("password");

		MemberDto dto = memberDao.selectMember(mdId);

		int state = 2;

		if (dto.getMb_pw().equals(pw))
		{
			memberDao.updateState(mdId, state);
		} else
		{

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = response.getWriter();

			writer.println("<html><head></head><body>");
			writer.println("<script language=\"javascript\">");
			writer.println("alert(\"비밀번호가 일치하지 않습니다. 다시 입력해 주세요.\");");
			writer.println("history.back();");
			writer.println("</script>");
			writer.println("</body></html>");
			writer.close();

			return null;

		}

		session.invalidate();

		return "main_view";
	}
	
	// 로그아웃
	@RequestMapping("/logout.do")
	public String logout(HttpSession session)
	{
		
		session.invalidate();
		
		return "main_view";
	}
	
	// 반려동물 등록 화면
	@RequestMapping("/petRegister.do")
	public String petRegister(Model model, HttpServletRequest request)
	{
		
		String mdNum = request.getParameter("mbNum");
		int num = Integer.parseInt(mdNum);
//		int num = 1;//테스트용
		MemberDto dto = memberDao.selectMember2(num);

		model.addAttribute("petRegister", dto);

		return "petRegister";
	}
	
	// 반려동물 정보 등록 및 반려동물 리스트 화면
	@RequestMapping("/petProfileCreate.do")
	public String petProfileCreate(Model model, HttpServletRequest request)
	{
		
		 // 파일 저장 경로
		
		String fileName = null;
		String dst = null;
		String filePath = null;
		
		try
		{
			filePath = servletContext.getRealPath("/upload/");

			List<Part> fileParts = request.getParts().stream()
					.filter(part -> "petImage".equals(part.getName()) && part.getSize() > 0)
					.collect(Collectors.toList());
			for (Part filePart : fileParts)
			{
				fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
				dst = filePath + "\\" + fileName;

				try (BufferedInputStream fin = new BufferedInputStream(filePart.getInputStream());
						BufferedOutputStream fout = new BufferedOutputStream(new FileOutputStream(dst)))
				{
					int data;
					while (true)
					{
						data = fin.read();
						if (data == -1)
							break;
						fout.write(data);
					}
				} catch (IOException e)
				{
					e.printStackTrace();
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		String name = request.getParameter("name");
		String mb_no = request.getParameter("mb_no");
		String birth = request.getParameter("birth");
		String pettype = request.getParameter("pettype");
		String breed = request.getParameter("breed");
		String gender = request.getParameter("gender");
		String weight = request.getParameter("weight");
		
		
		Double dWeight = Double.parseDouble(weight);
		
		pteListDao.insertPet(name, mb_no, birth, pettype, breed, gender, dWeight, dst, fileName, filePath);
		
		int mbNum = Integer.parseInt(mb_no);
		MemberDto dto = memberDao.selectMember2(mbNum);
		List<PetListDto> pDtos = pteListDao.petList(mbNum);
		
		model.addAttribute("member", dto);
		model.addAttribute("petList", pDtos);
		
		return "petList";
	}
	
	// 반려동물 등록 화면
	@RequestMapping("/petList.do")
	public String petList(Model model, HttpServletRequest request)
	{

		String mdId = request.getParameter("id");
		MemberDto dto = memberDao.selectMember(mdId);
		int mbNo = dto.getMb_no();
		List<PetListDto> pDtos = pteListDao.petList(mbNo);

		model.addAttribute("member", dto);
		model.addAttribute("petList", pDtos);

		return "petList";
	}
	
	// 주문조회
	@RequestMapping("/orderLookup.do")
	public String orderLookup(Model model, HttpServletRequest request)
	{
		String mdId = request.getParameter("id");
		MemberDto dto = memberDao.selectMember(mdId);
		int mbNo = dto.getMb_no();
		List<OrderProductDto> dtos = orderProductDao.selectOrderProduct(mbNo);
		model.addAttribute("member", dto);
		model.addAttribute("orderList", dtos);

		return "orderLookup";
	}
	
	// 주문조회 상태 갱신처리
	@PostMapping("/orderState.do")
	@ResponseBody
	public ResponseEntity<String> orderState(Model model, HttpServletRequest request)
	{
		String od_no = request.getParameter("orderno");
		String od_state = request.getParameter("state");
		int num = Integer.parseInt(od_no);

		try
		{
			orderProductDao.updateState(num, od_state);
			return ResponseEntity.ok().body("success");

		} catch (Exception e)
		{
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}
		
	}
	
	// 구매평 등록
	@PostMapping("/productRevie.do")
	@ResponseBody
	public ResponseEntity<String> productRevie(Model model, HttpServletRequest request)
	{
		
		 // 파일 저장 경로
		
		String originalName = null;
		String saveFileName = null;
		File serverPatheFullName = null;
		
		// 뷰로 전달할 정보를 저장하기 위한 Map타입의 변수

		try
		{
			// 서버의 물리적경로 가져오기
			String path = ResourceUtils.getFile(servletContext.getRealPath("/upload/")).toPath().toString();

			/*
			 * 파일업로드 위한 MultipartHttpServletRequest객체 생성 객체 생성과 동시에 파일업로드 완료됨. 나머지 폼값은
			 * Multipart가 통째로 받아서 처리한다.
			 */
			MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;

			// 업로드폼의 file속성 필드의 이름을 모두 읽음
			Iterator<String> itr = mhsr.getFileNames();

			MultipartFile mfile = null;
			String fileName = "";

			// 폼값받기 : 제목
			String title = mhsr.getParameter("image");

			// 업로드폼의 file속성의 필드의 갯수만큼 반복
			while (itr.hasNext())
			{

				// userfile1, userfile2....출력됨
				fileName = (String) itr.next();
				// System.out.println(fileName);

				// 서버로 업로드된 임시파일명 가져옴
				mfile = mhsr.getFile(fileName);
				// System.out.println(mfile);//CommonsMultipartFile@1366c0b 형태임

				// 한글깨짐방지 처리 후 업로드된 파일명을 가져온다.
				originalName =
						// mfile.getOriginalFilename();
						new String(mfile.getOriginalFilename().getBytes(), "UTF-8"); // Linux

				// 파일명이 공백이라면 while문의 처음으로 돌아간다.
				if ("".equals(originalName))
				{
					continue;
				}

				saveFileName = getUuid() + "." + originalName;

				// 설정한 경로에 파일저장
				serverPatheFullName = new File(path + File.separator + originalName);

				// 업로드한 파일을 지정한 파일에 저장한다.
				mfile.transferTo(serverPatheFullName);
				
				// 설정한 경로에 파일 저장 - saveFileName으로 저장 (복사)
		        File copiedFile = new File(path + File.separator + saveFileName);
		        Files.copy(serverPatheFullName.toPath(), copiedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);  // 파일 복사

			}
		} catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
		} catch (IllegalStateException e)
		{
			e.printStackTrace();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		
		String memberNo = request.getParameter("memberNo");
		String orderNo = request.getParameter("orderNo");
		String rating = request.getParameter("rating");
		String reviewText = request.getParameter("reviewText");
		
		int mbNum = Integer.parseInt(memberNo);
		int odNo = Integer.parseInt(orderNo);
		int star = Integer.parseInt(rating);
		String path = null;
		if(serverPatheFullName == null) {
			path = "";
			originalName = "";
			saveFileName = "";
		}else {
			
			path = serverPatheFullName.getPath();
		}
		
		MemberDto mDto = memberDao.selectMember2(mbNum);
		String mbNnme = mDto.getMb_name();
		OrdersDto oDto = ordersDao.selectOrders(odNo);
		int odNum = oDto.getOdNum();
		
		
		try {
			orderProductDao.insertProductRevie(odNum, mbNum, mbNnme, star, reviewText, path, originalName, saveFileName);
			return ResponseEntity.ok().body("success");
		}catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}
		
	}
	
	//취소/반품/교환
	@RequestMapping("/returnExchange.do")
	public String returnExchange(Model model, HttpServletRequest request)
	{
		String mdId = request.getParameter("id");
		MemberDto dto = memberDao.selectMember(mdId);
		int mbNo = dto.getMb_no();
		List<OrderProductDto> dtos = orderProductDao.selectReturnExchange(mbNo);
		model.addAttribute("member", dto);
		model.addAttribute("returnExchange", dtos);

		return "returnExchange";
	}
	
	// 관리자 - 판매관리
	@RequestMapping("/salesManagement.do")
	public String salesManagement(Model model, HttpServletRequest request)
	{
		
		// 한 페이지에 보여줄 항목 수
	    int pageSize = 10;

	    // 현재 페이지 - request에서 page 파라미터를 가져옴
	    String pageParam = request.getParameter("page");
	    int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
	    if(currentPage < 1) {
	    	currentPage = 1;
	    }

	    // 총 항목 수 계산
	    PageDto pDto = orderProductDao.orderTotal();
	    int totalCount = pDto.getTotal();
	    // 총 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    // MyBatis 쿼리에 필요한 offset 계산
	    int startRow = (currentPage - 1) * pageSize + 1; // 시작 행
	    int endRow = startRow + pageSize - 1; // 끝 행
	    
	    // 데이터 가져오기
	    List<OrderProductDto> salesManage = orderProductDao.selectPageSalesM(startRow, endRow);

	    // JSP에 값 전달
	    model.addAttribute("salesManage", salesManage);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", totalPages);

	    return "salesManagement";
	}
	
	// 관리자 - 구매평 관리
	@RequestMapping("/reviewManager.do")
	public String reviewManager(Model model, HttpServletRequest request)
	{
		
		// 한 페이지에 보여줄 항목 수
	    int pageSize = 10;

	    // 현재 페이지 - request에서 page 파라미터를 가져옴
	    String pageParam = request.getParameter("page");
	    int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
	    if(currentPage < 1) {
	    	currentPage = 1;
	    }

	    // 총 항목 수 계산
	    PageDto pDto = reviewDao.reviewTotal();
	    int totalCount = pDto.getTotal();
	    // 총 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    // MyBatis 쿼리에 필요한 offset 계산
	    int startRow = (currentPage - 1) * pageSize + 1; // 시작 행
	    int endRow = startRow + pageSize - 1; // 끝 행
	    
	    // 데이터 가져오기
	    List<ProductReviewDto> reviewManage = reviewDao.selectReview(endRow, startRow);

	    // JSP에 값 전달
	    model.addAttribute("reviewManager", reviewManage);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", totalPages);

	    return "reviewManager";
	}
	
	// 관리자 - 구매평 관리 - 구매평 댓글
	@RequestMapping("/reviewReply.do")
	public String reviewReply(Model model, HttpServletRequest request)
	{
		String id = request.getParameter("reviewId");
		String date = request.getParameter("reviewDate");
		String name = request.getParameter("mbName");
		String text = request.getParameter("reviewText");

	    // JSP에 값 전달
	    model.addAttribute("id", id);
	    model.addAttribute("date", date);
	    model.addAttribute("name", name);
	    model.addAttribute("text", text);

	    return "reviewReply";
	}
	
	// 관리자 - 구매평 답변 - 답변 등록
	@PostMapping("/submitReply.do")
	@ResponseBody
	public ResponseEntity<String> submitReply(Model model, HttpServletRequest request, HttpSession session)
	{


		String reviewId = request.getParameter("reviewId");
		String adminId = (String) session.getAttribute("adminId");
		String replyText = request.getParameter("replyText");
		
		int rpId = Integer.parseInt(reviewId);

		try
		{
			reviewReplyDao.insertReply(rpId, adminId, replyText);
			reviewDao.updateHasReply(rpId, "Y");
			return ResponseEntity.ok().body("success");
		} catch (Exception e)
		{
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}

	}
	
	// 관리자 - 구매평 답변 - 숨기기
	@PostMapping("/hideReview.do")
	@ResponseBody
	public ResponseEntity<String> hideReview(Model model, HttpServletRequest request)
	{

		String reviewId = request.getParameter("reviewId");

		int rpId = Integer.parseInt(reviewId);

		try
		{
			reviewDao.updateVisibility(rpId, "N");
			return ResponseEntity.ok().body("success");
		} catch (Exception e)
		{
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}

	}
	// 동물병원
	@RequestMapping("/hospitalMap.do")
	public String hospitalMap(Model model, HttpServletRequest request)
	{
		
		model.addAttribute("kakaoKey", KAKAO_KEY);

	    return "hospitalMap";
	}
	// 애견카페
	@RequestMapping("/cafeMap.do")
	public String cafeMap(Model model, HttpServletRequest request)
	{
		
		model.addAttribute("kakaoKey", KAKAO_KEY);

	    return "cafeMap";
	}
	// 캠페인
	@RequestMapping("/petAdoption.do")
	public String petAdoption(Model model, HttpServletRequest request)
	{
		
	    return "petAdoption";
	}
	// 회원 관리
	@RequestMapping("/memberManagement.do")
	public String memberManagement(Model model, HttpServletRequest request)
	{
		
		// 한 페이지에 보여줄 항목 수
	    int pageSize = 10;

	    // 현재 페이지 - request에서 page 파라미터를 가져옴
	    String pageParam = request.getParameter("page");
	    int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
	    if(currentPage < 1) {
	    	currentPage = 1;
	    }

	    // 총 항목 수 계산
	    PageDto pDto = memberDao.memberAllTotal();
	    int totalCount = pDto.getTotal();
	    // 총 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    // MyBatis 쿼리에 필요한 offset 계산
	    int startRow = (currentPage - 1) * pageSize + 1; // 시작 행
	    int endRow = startRow + pageSize - 1; // 끝 행
	    
	    // 데이터 가져오기
	    List<MemberDto> memberAll = memberDao.memberPageList(endRow, startRow);

	    // JSP에 값 전달
	    model.addAttribute("memberManage", memberAll);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", totalPages);
		
		
	    return "memberManagement";
	}
	
	// 회원관리 - 강퇴,정지
	@PostMapping("/updateMemberState.do")
	@ResponseBody
	public ResponseEntity<String> updateMemberState(Model model, HttpServletRequest request)
	{
		String[] memberList = request.getParameterValues("memberList");
		String action = request.getParameter("action");
		try
		{
			if(action.equals("expel")) {
				for (String memberId : memberList) {
					int mbNo = Integer.parseInt(memberId);
					//회원강퇴
					memberDao.updateNoState(mbNo, 3);
				}
			}else  if(action.equals("suspend")) {
				for (String memberId : memberList) {
					int mbNo = Integer.parseInt(memberId);
					//회원정지
					memberDao.updateNoState(mbNo, 4);
				}
			}
			return ResponseEntity.ok().body("success");

		} catch (Exception e)
		{
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}

	}
	// 회원관리 - 카테고리 검색
	@RequestMapping("/keywordMemberManagement.do")
	public String keywordMemberManagement(Model model, HttpServletRequest request)
	{
		
		// 한 페이지에 보여줄 항목 수
	    int pageSize = 10;

	    // 현재 페이지 - request에서 page 파라미터를 가져옴
	    String pageParam = request.getParameter("page");
	    String category = request.getParameter("category");
	    String keyword = request.getParameter("keyword");
	    int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
	    if(currentPage < 1) {
	    	currentPage = 1;
	    }
	    //카테고리 구분
	    PageDto pDto = null;
	    if(category.equals("all")) {
	    	pDto = memberDao.memberAllTotal();
	    }else if(category.equals("nickname")) {
	    	pDto = memberDao.memberNickNameTotal("%" + keyword + "%");
	    }else if(category.equals("id")) {
	    	pDto = memberDao.memberIdTotal("%" + keyword + "%");
	    }else if(category.equals("phone")) {
	    	pDto = memberDao.memberPhoneTotal("%" + keyword + "%");
	    }else if(category.equals("status")) {
	    	if(keyword.equals("정상")) {
	    		pDto = memberDao.memberStateTotal(1);
	    	}else if(keyword.equals("탈퇴")) {
	    		pDto = memberDao.memberStateTotal(2);
	    	}else if(keyword.equals("강퇴")) {
	    		pDto = memberDao.memberStateTotal(3);
	    	}else if(keyword.equals("정지")) {
	    		pDto = memberDao.memberStateTotal(4);
	    	}
	    }
	    
	    
	    // 총 항목 수 계산
	    int totalCount = pDto.getTotal();
	    // 총 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    // MyBatis 쿼리에 필요한 offset 계산
	    int startRow = (currentPage - 1) * pageSize + 1; // 시작 행
	    int endRow = startRow + pageSize - 1; // 끝 행
	    
	    // 데이터 가져오기
	    List<MemberDto> memberDtos = null;
	    
	    if(category.equals("all")) {
	    	memberDtos = memberDao.memberAllSelectList(endRow, startRow, "%" + keyword + "%");
	    }else if(category.equals("nickname")) {
	    	memberDtos = memberDao.memberNickNameSelectList(endRow, startRow, "%" + keyword + "%");
	    }else if(category.equals("id")) {
	    	memberDtos = memberDao.memberIdSelectList(endRow, startRow, "%" + keyword + "%");
	    }else if(category.equals("phone")) {
	    	memberDtos = memberDao.memberPhoneSelectList(endRow, startRow, "%" + keyword + "%");
	    }else if(category.equals("status")) {
	    	if(keyword.equals("정상")) {
	    		memberDtos = memberDao.memberStateSelectList(endRow, startRow, 1);
	    	}else if(keyword.equals("탈퇴")) {
	    		memberDtos = memberDao.memberStateSelectList(endRow, startRow, 2);
	    	}else if(keyword.equals("강퇴")) {
	    		memberDtos = memberDao.memberStateSelectList(endRow, startRow, 3);
	    	}else if(keyword.equals("정지")) {
	    		memberDtos = memberDao.memberStateSelectList(endRow, startRow, 4);
	    	}
	    }

	    // JSP에 값 전달
	    model.addAttribute("memberManage", memberDtos);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", totalPages);
		
		
	    return "memberManagement";
	}

	// uuid 생성할 메서드 선언
	/*
	 * UUID(Universally unique identifier), 범용 고유 식별자. UUID.randomUUID().toString()
	 * 으로 생성하면 3d6f4151-5663-4f43-ab16-cb8e38a4ddc6 와 같이 4개의 하이픈과 32개의 문자로 이루어진 문자열을
	 * 반환한다.
	 */
	public static String getUuid(){
		String uuid = UUID.randomUUID().toString();
		//System.out.println(uuid);		
		uuid = uuid.replaceAll("-", "");
		//System.out.println("생성된UUID:"+ uuid);
		return uuid;
	}
	
	//통합검색
	@RequestMapping("/searchAll")    
    public String IntegratedSearch(@RequestParam(value = "sKeyword", required = false) String sKeyword,
    							   Model model) {
    	
    	System.out.println("sKeyword : " + sKeyword);
    	
    	// 제품 검색
        List<PDto> productList = pService.getProductsByKeyword(sKeyword);
        model.addAttribute("productList", productList);
        int productCount = productList.size(); // 제품 수 세기
        
        for (PDto product : productList) {
            System.out.println("상품명: " + product.getPdName());
            System.out.println("가격: " + product.getPd_price());
        }
        
        // 게시판 검색
        List<BoardDto> boardList = sService.getBoardsByKeyword(sKeyword);
        for (BoardDto board : boardList) {
        	String content = board.getBd_content();
            String contentWithoutImages = removeImgTags(content);  // 이미지 태그 제거
            board.setBd_content_delimg(contentWithoutImages);  // 수정된 내용 설정
            
        	board.extractImageUrl(); // 각 게시글에서 이미지 URL 추출
        }
        model.addAttribute("boardList", boardList);
        int boardCount = boardList.size(); // 게시판 수 세기
        
        System.out.println("productList: " + productList);
        System.out.println("boardList: " + boardList);
        
        // 검색 결과 수 합산
        int totalCount = productCount + boardCount;
        model.addAttribute("totalCount", totalCount); // 총 결과 수 모델에 추가
    	
        return "searchview";                 
	}
	
	// 정규식을 사용해 <img> 태그를 제거하는 메서드
    private String removeImgTags(String content) {
        if (content == null) {
            return null;
        }

        // <img><br> 태그를 정규식으로 모두 제거
        return content.replaceAll("(?i)<img[^>]*>(\\s*<br\\s*/?>)?", "<!--IMG_REMOVED-->");
    }
	
}

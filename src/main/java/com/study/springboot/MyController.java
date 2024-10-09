package com.study.springboot;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Paths;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dao.IOrderProductDao;
import com.study.springboot.dao.IPetListDao;
import com.study.springboot.dao.IProductReviewDao;
import com.study.springboot.dao.IReviewReplyDao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrderProductDto;
import com.study.springboot.dto.PageDto;
import com.study.springboot.dto.PetListDto;
import com.study.springboot.dto.ProductReviewDto;

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
        return "myProfile_view";
    }
    
    // 회원정보 수정 화면
    @RequestMapping("/editProfile.do")
    public String editProfile(Model model, HttpServletRequest request) {
    	
    	String mdId = request.getParameter("id");
		MemberDto dto = memberDao.selectMember(mdId);
		model.addAttribute("editProfile", dto);
        return "editProfile";
    }
    
    // 회원정보 수정 및 내 프로필 이동
    @RequestMapping("/updateProfile.do")
    public String updateProfile(HttpServletRequest request, HttpServletResponse response, Model model) throws ServletException, IOException {
    	
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
		
		String path = serverPatheFullName.getPath();
    	String id = request.getParameter("id");
    	String nickName = request.getParameter("nickName");
    	String phone = request.getParameter("phone");
    	String zipcode = request.getParameter("zipcode");
    	String addr1 = request.getParameter("addr1");
    	String addr2 = request.getParameter("addr2");
    	
    	memberDao.updateProfile(id, nickName, phone, zipcode, addr1, addr2, originalName, saveFileName, path);
    	
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
		String path = serverPatheFullName.getPath();
		MemberDto mDto = memberDao.selectMember2(mbNum);
		String mbNnme = mDto.getMb_name();
		
		
		try {
			orderProductDao.insertProductRevie(odNo, mbNum, mbNnme, star, reviewText, path, originalName, saveFileName);
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
	    int pageSize = 5;

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
//		String adminId = "admin"; // 테스트용 어드민 아이디
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
	
	@RequestMapping("/map.do")
	public String map(Model model, HttpServletRequest request)
	{
		
		model.addAttribute("kakaoKey", KAKAO_KEY);

	    return "map";
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
	
}

package com.study.springboot;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dao.IOrderProductDao;
import com.study.springboot.dao.IPetListDao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrderProductDto;
import com.study.springboot.dto.PetListDto;

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
    private ServletContext servletContext;

    @RequestMapping("/")
    public String root() throws Exception{
        return "redirect:main_view.do";
    }
 
    @RequestMapping("/test1")    // localhost:8081/test1
    public String test1() {
        return "test1";          // 실제 호출 될 /WEB-INF/views/test1.jsp       
    }
    
    @RequestMapping("/main_view.do")
    public String main() {
    	
        return "main_view";                 
    }
    
    //내 프로필 화면
    @RequestMapping("/myProfile_view.do")
    public String myProfileView(HttpServletRequest request, Model model, HttpSession session) {
    	
    	String mdId = (String) session.getAttribute("id");
//    	String mdId = "test"; //테스트용
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
    	
    	String id = request.getParameter("id");
    	String nickName = request.getParameter("nickName");
    	String phone = request.getParameter("phone");
    	String zipcode = request.getParameter("zipcode");
    	String addr1 = request.getParameter("addr1");
    	String addr2 = request.getParameter("addr2");
    	
    	memberDao.updateProfile(id, nickName, phone, zipcode, addr1, addr2);
    	
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
}

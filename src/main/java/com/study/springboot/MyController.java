package com.study.springboot;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dto.MemberDto;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyController {
	
	@Autowired
	IMemberDao memberDao;

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
//    	String id = "test"; //테스트용
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
    	
    	int iZipcode = Integer.parseInt(zipcode);
    	
    	memberDao.updateProfile(id, nickName, phone, iZipcode, addr1, addr2);
    	
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
		int num = 1;//테스트용
		MemberDto dto = memberDao.selectMember2(num);

		model.addAttribute("petRegister", dto);

		return "petRegister";
	}
	
	@RequestMapping("/petProfileCreate.do")
	public String petProfileCreate(Model model, HttpServletRequest request)
	{
		
		String mb_no = request.getParameter("mb_no");
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String pettype = request.getParameter("pettype");
		String breed = request.getParameter("breed");
		String gender = request.getParameter("gender");
		String weight = request.getParameter("weight");
		int num = 1;//테스트용
		

		return "petRegister";
	}
    
}

package com.study.springboot.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dao.IQnaReplyDao;
import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.service.AdminService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;
    
    @Autowired
    private IQnaReplyDao qnaReplyDao;
    
    @Autowired
    private IQnADao qnaDao;
    
    @RequestMapping("/admin.do")
    public String main(Model model) {
        return "admin_login"; // admin_login.jsp를 반환
    }
    
    @PostMapping("/loginOk_admin.do")
    @ResponseBody
    public String login(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session) {
    	
        boolean isValidAdmin = adminService.validateLogin(id, pw);
        
        String jsonResponse;
        if (isValidAdmin) {
        	session.setAttribute("adminId", id); // 세션에 로그인한 아이디 저장
        	jsonResponse = "{\"code\": \"success\", \"desc\": \"로그인 되었습니다.\"}";
        } else {
        	jsonResponse = "{\"code\": \"error\", \"desc\": \"아이디 또는 비밀번호가 잘못되었습니다.\"}";
        }
        return jsonResponse;
    }
    
    @RequestMapping("/admin_membership.do")
    public String membership(Model model) {
        return "admin_membership"; // admin_login.jsp를 반환
    }
    
    // 관리자 - QnA 관리화면
    @RequestMapping("/admin_qna.do")
    public String getAllQna(@RequestParam(name="page", defaultValue = "1") int page,
    						Model model) {
    	
    	List<QDto> qnaList = adminService.getAllQna();
        System.out.println(qnaList);
        
        // 페이지네이션 설정
        int pageSize = 10; // 페이지당 항목 수
        int totalQnAs = qnaList.size(); // 전체 상품 수
        int startRow = (page - 1) * pageSize; // 시작 인덱스
        int endRow = Math.min(startRow + pageSize, totalQnAs);
        
        List<QDto> paginatedQnas = qnaList.subList(startRow, endRow);
        
        model.addAttribute("qnaList", paginatedQnas);
        model.addAttribute("currentPage", page); // 현재 페이지 번호
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", (int) Math.ceil((double) totalQnAs / pageSize)); // 전체 페이지 수
        model.addAttribute("startPage", Math.max(1, page - 2)); // 시작 페이지
        model.addAttribute("endPage", Math.min((int) Math.ceil((double) totalQnAs / pageSize), page + 2)); // 끝 페이지
        
        return "admin_qna"; 
    }
    
	// 관리자 - QnA 답변화면
	@RequestMapping("/qnaReply.do")
	public String qnaReply(Model model, HttpServletRequest request)
	{
		String qnaNo = request.getParameter("qnaNo");
		String number = request.getParameter("number");
		String qnaDate = request.getParameter("qnaDate");
		String qnaName = request.getParameter("qnaName");
		String qnaContent = request.getParameter("qnaContent");
		
		SimpleDateFormat targetFormat = null;
		Date date = null;
		
		try {
			SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", java.util.Locale.ENGLISH);
			targetFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			date = originalFormat.parse(qnaDate);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		String fQnaDate = targetFormat.format(date);

		// JSP에 값 전달
		model.addAttribute("qnaNo", qnaNo);
		model.addAttribute("number", number);
		model.addAttribute("qnaDate", fQnaDate);
		model.addAttribute("qnaName", qnaName);
		model.addAttribute("qnaContent", qnaContent);

		return "qnaReply";
	}
	
	// 관리자 - QnA 답변 - 답변 등록
	@PostMapping("/submitQnaReply.do")
	@ResponseBody
	public ResponseEntity<String> submitReply(Model model, HttpServletRequest request, HttpSession session)
	{

		String qnaNo = request.getParameter("qnaNo");
		String adminId = (String) session.getAttribute("adminId");
//		String adminId = "admin"; // 테스트용 어드민 아이디
		String qnaText = request.getParameter("qnaText");

		int qaNo = Integer.parseInt(qnaNo);

		try
		{
			qnaReplyDao.insertQnaReply(qaNo, adminId, qnaText);
			qnaDao.updateRstate(qaNo, "Y");
			return ResponseEntity.ok().body("success");
		} catch (Exception e)
		{
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}

	}
	
	// 관리자 - QnA 답변 - 숨기기
	@PostMapping("/hideQna.do")
	@ResponseBody
	public ResponseEntity<String> hideReview(Model model, HttpServletRequest request)
	{

		String qnaNo = request.getParameter("qnaNo");

		int qaNo = Integer.parseInt(qnaNo);

		try
		{
			qnaDao.updateHide(qaNo, "Y");
			return ResponseEntity.ok().body("success");
		} catch (Exception e)
		{
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}

	}
	
	// 관리자 - 커뮤니티 관리화면
    @RequestMapping("/admin_community.do")
    public String ManagingCommunityContent(@RequestParam(name="page", defaultValue = "1") int page,
    						Model model) {
    	
    	List<BoardDto> communityList = adminService.getAllCommunityContent();
        System.out.println(communityList);
        
        // 페이지네이션 설정
        int pageSize = 10; // 페이지당 항목 수
        int totalComus = communityList.size(); // 전체 상품 수
        int startRow = (page - 1) * pageSize; // 시작 인덱스
        int endRow = Math.min(startRow + pageSize, totalComus);
        
        List<BoardDto> paginatedQnas = communityList.subList(startRow, endRow);
        
        model.addAttribute("communityList", paginatedQnas);
        model.addAttribute("currentPage", page); // 현재 페이지 번호
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", (int) Math.ceil((double) totalComus / pageSize)); // 전체 페이지 수
        model.addAttribute("startPage", Math.max(1, page - 2)); // 시작 페이지
        model.addAttribute("endPage", Math.min((int) Math.ceil((double) totalComus / pageSize), page + 2)); // 끝 페이지
        
        return "admin_community"; 
    }
    
    // 관리자 - 커뮤니 관리화면 > 선택항목 숨기기
    @PostMapping("/hideCommunityPosts")
    @ResponseBody
    public Map<String, Object> hideCommunityPosts(@RequestBody Map<String, Object> requestData) {
        
    	List<Integer> bdNos = (List<Integer>) requestData.get("bdNos");
        boolean success = adminService.hidePosts(bdNos);

        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        return response;
    }
	
	
	
	
    
}

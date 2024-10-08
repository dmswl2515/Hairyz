package com.study.springboot.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dto.PDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;
import com.study.springboot.service.AdminService;
import com.study.springboot.service.QnAService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;
    

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
    
    @RequestMapping("/admin_qna.do")
    public String getAllQna(@RequestParam(defaultValue = "1") int page,
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
    
    
}

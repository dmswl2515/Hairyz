package com.study.springboot.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private MemberService memberService;

    @RequestMapping("/admin.do")
    public String join(Model model) {
        return "admin"; // admin.jsp를 반환
    }

    
    @PostMapping("/loginOk_admin.do")
    @ResponseBody
    public String login(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session) {
    	
        boolean isValidUser = memberService.validateLogin(id, pw);
        
        String jsonResponse;
        if (isValidUser) {
        	session.setAttribute("userId", id); // 세션에 로그인한 아이디 저장
        	jsonResponse = "{\"code\": \"success\", \"desc\": \"로그인 되었습니다.\"}";
        } else {
        	jsonResponse = "{\"code\": \"error\", \"desc\": \"아이디 또는 비밀번호가 잘못되었습니다.\"}";
        }
        return jsonResponse;
    }



}

package com.study.springboot.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.mailSender.EmailService;
import com.study.springboot.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MbController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private IMemberDao memberDao;
    
    @RequestMapping("/join.do")
    public String join(Model model) {
        return "join"; // join.jsp를 반환
    }

    @PostMapping("/joinOk.do")
    @ResponseBody
    public String joinOk(@RequestParam Map<String, String> paramMap, HttpSession session) {
    	String mbId = (String) paramMap.get("mb_id");
        String sns = (String) paramMap.get("mb_sns"); // SNS 회원 여부 확인

        // 기존 회원인지 확인
        MemberDto dto = memberDao.selectMember(mbId);
        if (dto != null) {
            return "{\"code\":\"fail\", \"desc\":\"이미 존재하는 이메일입니다.\"}";
        }

        // 새로운 회원 등록
        if ("Y".equals(sns)) {
        	paramMap.put("mb_sns", "Y");
        } else {
        	paramMap.put("mb_sns", "");
        }
    	
        int result = memberService.registerMember(paramMap);
        // JSON 형식으로 응답 준비
        String jsonResponse;
        
        if (result > 0) {
        	String email = paramMap.get("mb_id"); // 사용자가 입력한 아이디
            session.setAttribute("userId", email); // 세션에 아이디 저장
            
            jsonResponse = "{\"code\": \"success\", \"desc\": \"회원가입을 축하합니다! \"}";
        } else {
            jsonResponse = "{\"code\": \"error\", \"desc\": \"회원가입에 실패했습니다.\"}";
        }
        return jsonResponse; // JSON 응답 반환
    }

    @PostMapping("/checkDuplicateEmail.do")
    @ResponseBody
    public String checkDuplicateEmail(@RequestParam("mb_id") String email) {
        boolean exists = memberService.isEmailExists(email); // 이메일 존재 여부 확인
        return exists ? "exists" : "available"; // 중복 여부에 따라 응답
    }


    @RequestMapping("/login.do")
    public String login() {
        return "login"; // login.jsp 반환
    }
    
    @PostMapping("/loginOk.do")
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
    
    @PostMapping("/checkSnsLoginEmail.do")
    public ResponseEntity<Map<String, String>> checkSnsLoginEmail(@RequestBody Map<String, String> params, HttpSession session) {
        String email = params.get("email");
        MemberDto dto = memberDao.findById(email);
        Map<String, String> response = new HashMap<>();
        if (dto != null) {
            // SNS 계정으로 로그인된 경우 세션에 아이디 저장
            session.setAttribute("userId", dto.getMb_id()); 
            response.put("code", "exists");
            response.put("desc", "SNS 계정으로 로그인 되었습니다.");
        } else {
            response.put("code", "not_found");
            response.put("desc", "SNS 계정과 연동된 이메일이 없습니다. 추가 정보 입력이 필요합니다.");
        }
        return ResponseEntity.ok(response);
    }
    
    @RequestMapping("/findInfo.do")
    public String find(Model model) {
        return "find_info"; // join.jsp를 반환
    }

}

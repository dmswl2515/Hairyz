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

@Controller
public class MbController {

    @Autowired
    private MemberService memberService;

    @RequestMapping("/join.do")
    public String join(Model model) {
        return "join"; // join.jsp를 반환
    }

    @PostMapping("/joinOk.do")
    @ResponseBody
    public String joinOk(@RequestParam Map<String, String> paramMap) {
        int result = memberService.registerMember(paramMap);
        // JSON 형식으로 응답 준비
        String jsonResponse;
        if (result > 0) {
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

}

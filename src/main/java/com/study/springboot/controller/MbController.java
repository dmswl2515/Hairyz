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
@RequestMapping("/user")
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
    	// mb_zipcode 변환 로직
        String zipcodeStr = paramMap.get("mb_zipcode");
        if (zipcodeStr != null && !zipcodeStr.isEmpty()) {
            try {
                int zipcode = Integer.parseInt(zipcodeStr); // String을 int로 변환
                paramMap.put("mb_zipcode", String.valueOf(zipcode)); // 변환된 값을 다시 String으로 저장
            } catch (NumberFormatException e) {
                return "{\"code\":\"error\", \"desc\":\"우편번호 형식이 올바르지 않습니다.\"}";
            }
        }

        
        int result = memberService.registerMember(paramMap);
        if (result > 0) {
            return "{\"code\":\"success\", \"desc\":\"회원가입이 완료되었습니다.\"}";
        } else {
            return "{\"code\":\"error\", \"desc\":\"회원가입에 실패했습니다.\"}";
        }
    }
    
    @PostMapping("/checkDuplicateEmail.do")
    @ResponseBody
    public String checkDuplicateEmail(@RequestParam("mb_id") String email) {
        boolean exists = memberService.isEmailExists(email); // 이메일 존재 여부 확인
        return exists ? "exists" : "available"; // 중복 여부에 따라 응답
    }

}

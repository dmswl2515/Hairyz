package com.study.springboot.mailSender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EmailController {

    @Autowired
    private EmailService emailService;

    // 아이디 찾기
    @PostMapping("/findId")
    public String findId(@RequestParam("phone") String phone) {
        return emailService.findIdByPhone(phone);
    }

    // 비밀번호 찾기
    @PostMapping("/findPw")
    public void findPassword(@RequestParam("id") String id) {
    	emailService.findPasswordById(id);
    }

}

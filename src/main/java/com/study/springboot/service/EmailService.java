package com.study.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendEmail(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to); // 수신자 이메일
        message.setSubject(subject); // 이메일 제목
        message.setText(text); // 이메일 본문 내용

        mailSender.send(message); // 이메일 전송
    }
}

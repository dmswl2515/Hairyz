package com.study.springboot.mailSender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.study.springboot.dao.IMemberDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private IMemberDao memberDao;
    
    // 아이디 찾기
    public String findIdByPhone(String phoneNumber) {
        String email = memberDao.findEmailByPhone(phoneNumber);
        if (email != null) {
            sendEmail(email, "털뭉치즈 아이디 찾기 알림", "회원님의 아이디는 " + email + " 입니다.");
            return email;
        } else {
            throw new RuntimeException("해당 전화번호로 가입된 회원이 없습니다.");
        }
    }

    // 비밀번호 찾기
    public void findPasswordById(String id) {
        String password = memberDao.findPwById(id);
        if (password != null) {
            // 비밀번호를 복호화하여 이메일로 보내는 로직
            sendEmail(id, "털뭉치즈 비밀번호 찾기 알림", "회원님의 비밀번호는 " + password + " 입니다."); // 비밀번호를 직접적으로 보내는 것은 권장하지 않음
        } else {
            throw new RuntimeException("해당 아이디로 가입된 회원이 없습니다.");
        }
    }

    // 이메일 발송 메서드
    private void sendEmail(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to); // 수신자 이메일
        message.setSubject(subject); // 이메일 제목
        message.setText(text); // 이메일 본문 내용

        mailSender.send(message); // 이메일 전송
    }
}

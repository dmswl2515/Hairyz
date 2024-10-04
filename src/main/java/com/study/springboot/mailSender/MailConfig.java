package com.study.springboot.mailSender;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
public class MailConfig {

    @Value("${spring.mail.username}")
    private String username; // Gmail 계정 사용자 이름

    @Value("${spring.mail.password}")
    private String password;

    @Bean
    public JavaMailSender getJavaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com"); // Gmail의 SMTP 서버 주소
        mailSender.setPort(587); // Gmail SMTP 포트

        mailSender.setUsername(username); // 사용자 이름 설정
        mailSender.setPassword(password); // 환경 변수에서 가져온 비밀번호 설정

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS 사용
        props.put("mail.debug", "true");
        
        mailSender.setJavaMailProperties(props);
        mailSender.setDefaultEncoding("UTF-8");
출처: https://cn-c.tistory.com/95 [Codename Cathy:티스토리]

        return mailSender;
    }
}

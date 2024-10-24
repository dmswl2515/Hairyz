package com.study.springboot.mailSender;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	
	@Value("${EMAIL_HOST}")
    private String EMAIL_HOST;

    @Value("${EMAIL_PORT}")
    private int EMAIL_PORT;

    @Value("${EMAIL_USERNAME}")
    private String EMAIL_USERNAME;

    @Value("${EMAIL_PASSWORD}")
    private String EMAIL_PASSWORD;

    @Bean
    public JavaMailSender getJavaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(EMAIL_HOST); // Gmail의 SMTP 서버 주소
        mailSender.setPort(EMAIL_PORT); // SMTP 포트

        mailSender.setUsername(EMAIL_USERNAME); // 사용자 이메일
        mailSender.setPassword(EMAIL_PASSWORD); // 이메일 비밀번호

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS 사용
        props.put("mail.debug", "true");
        
        mailSender.setJavaMailProperties(props);
        mailSender.setDefaultEncoding("UTF-8");

        return mailSender;
    }
}

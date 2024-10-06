package com.study.springboot.mailSender;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import io.github.cdimascio.dotenv.Dotenv;

@Configuration
public class MailConfig {

	private final Dotenv dotenv = Dotenv.load(); 

    @Bean
    public JavaMailSender getJavaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(dotenv.get("EMAIL_HOST")); // Gmail의 SMTP 서버 주소
        mailSender.setPort(Integer.parseInt(dotenv.get("EMAIL_PORT"))); // SMTP 포트

        mailSender.setUsername(dotenv.get("EMAIL_USERNAME")); // 사용자 이메일
        mailSender.setPassword(dotenv.get("EMAIL_PASSWORD")); // 이메일 비밀번호

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

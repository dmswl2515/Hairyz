package com.study.springboot.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nl.captcha.Captcha;

@RestController
@RequestMapping("/captcha")
public class CaptchaController {

    @GetMapping("/image")
    public void getCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Captcha captcha = new Captcha.Builder(200, 50)
                .addText()
                .addNoise()
                .addBackground()
                .build();

        request.getSession().setAttribute("captcha", captcha);
        response.setContentType("image/png");
        BufferedImage captchaImage = captcha.getImage();
        ImageIO.write(captchaImage, "png", response.getOutputStream());
    }

    @PostMapping("/verify")
    @ResponseBody
    public String verifyCaptcha(HttpServletRequest request, @RequestParam("userCaptcha") String userCaptcha) {
        Captcha captcha = (Captcha) request.getSession().getAttribute("captcha");
        if (captcha != null && captcha.isCorrect(userCaptcha)) {
            return "캡차 인증이 완료되었습니다!";
        } else {
            return "캡차 인증에 실패했습니다.";
        }
    }
}


package com.study.springboot;
import java.util.Base64;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class IncodingBase64{

	public static String encode(byte[] data) {
        return Base64.getEncoder().encodeToString(data);
    }
}
package com.study.springboot;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@TestPropertySource(locations = "classpath:application-API-KEY.properties")

@SpringBootTest
class HairyzApplicationTests {

	@Test
	void contextLoads() {
		System.out.println("안녕하세요!");
	}

}

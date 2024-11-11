package com.study.springboot;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@TestPropertySource(locations = "classpath:application-API-KEY.properties")
//@TestPropertySource(properties = {
//	"KAKAO_KEY_ADMIN=8f930b29f6448b762f8699aa9f3794db",	
//	"GOOGLE_KEY=714732093906-kud1iod6kpo8t9m01k6l6dki2mp461hq.apps.googleusercontent.com",
//	"KAKAO_KEY=3fe60097c9ec0969b537421877e8ae54",
//	"NAVER_KEY=YbQ2xy32RJJryAeB2oB8",
//	"FB_KEY=535635602529499",
//	"EMAIL_HOST=smtp.gmail.com",
//	"EMAIL_PORT=587",
//	"EMAIL_USERNAME=dailydev89@gmail.com",
//	"EMAIL_PASSWORD=cfwe psrz daeo iith",
//	"BOOTPAY_KEY=6703330ccc5274a3ac3fc385",
//})






@SpringBootTest
class HairyzApplicationTests {

	@Test
	void contextLoads() {
		System.out.println("안녕하세요.");
	}

}

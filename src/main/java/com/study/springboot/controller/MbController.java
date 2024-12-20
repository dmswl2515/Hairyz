package com.study.springboot.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MbController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private IMemberDao memberDao;

    @Value("${KAKAO_KEY}")
    private String KAKAO_KEY;
    
    @Value("${GOOGLE_KEY}")
    private String DAILY_GOOGLE_KEY;
    
    @Value("${KAKAO_KEY}")
    private String DAILY_KAKAO_KEY;
    
    @Value("${FB_KEY}")
    private String DAILY_FB_KEY;
    
    @RequestMapping("/join.do")
    public String join(Model model) {
    	
    	model.addAttribute("kakaoKey", KAKAO_KEY);
    	
        return "join"; // join.jsp를 반환
    }

    @PostMapping("/joinOk.do")
    @ResponseBody
    public String joinOk(@RequestParam Map<String, String> paramMap, HttpSession session) {
    	String mbId = (String) paramMap.get("mb_id");
        String sns = (String) paramMap.get("mb_sns"); // SNS 회원 여부 확인

        // 기존 회원인지 확인
        MemberDto dto = memberDao.selectMember(mbId);
        if (dto != null) {
            return "{\"code\":\"fail\", \"desc\":\"이미 존재하는 이메일입니다.\"}";
        }

        // 새로운 회원 등록
        if ("Y".equals(sns)) {
        	paramMap.put("mb_sns", "Y");
        } else {
        	paramMap.put("mb_sns", "");
        }
    	
        int result = memberService.registerMember(paramMap);
        // JSON 형식으로 응답 준비
        String jsonResponse;
        
        if (result > 0) {
        	String email = paramMap.get("mb_id"); // 사용자가 입력한 아이디
            session.setAttribute("joinId", email); // 세션에 아이디 저장
            
            jsonResponse = "{\"code\": \"success\", \"desc\": \"회원가입을 축하합니다! \"}";
        } else {
            jsonResponse = "{\"code\": \"error\", \"desc\": \"회원가입에 실패했습니다.\"}";
        }
        return jsonResponse; // JSON 응답 반환
    }

    @PostMapping("/checkDuplicateEmail.do")
    @ResponseBody
    public String checkDuplicateEmail(@RequestParam("mb_id") String email) {
        boolean exists = memberService.isEmailExists(email); // 이메일 존재 여부 확인
        return exists ? "exists" : "available"; // 중복 여부에 따라 응답
    }


    @RequestMapping("/login.do")
    public String login(Model model) {
    	
    	model.addAttribute("kakaoKey", KAKAO_KEY);
    	model.addAttribute("googleClientId", DAILY_GOOGLE_KEY);
    	model.addAttribute("kakaoClientId", DAILY_KAKAO_KEY);
    	model.addAttribute("facebookAppId", DAILY_FB_KEY);
    	
        return "login"; // login.jsp 반환
    }
    
    @PostMapping("/loginOk.do")
    @ResponseBody
    public String login(@RequestParam("id") String id, @RequestParam("pw") String pw, @RequestParam(value = "redirect", required = false) String redirect, 
    					HttpServletRequest request, HttpSession session) {
    	
    	MemberDto member = memberDao.findById(id);  // 회원 정보를 먼저 가져옴
        String jsonResponse;

        if (member == null) {
            // 아이디가 존재하지 않음
            jsonResponse = "{\"code\": \"error\", \"desc\": \"아이디 또는 비밀번호가 잘못되었습니다.\"}";
            return jsonResponse;
        }

        boolean isValidUser = memberService.validateLogin(id, pw);  // 아이디와 비밀번호 검증

        if (isValidUser) {
            int mbState = member.getMb_state();  // 회원 상태를 가져옴
            
            // 세션 초기화
            session.invalidate();  // 기존 세션 무효화
            session = request.getSession(true);  // 새로운 세션 생성

            if (mbState == 1) {
                // 정상 회원인 경우
                session.setAttribute("userId", member.getMb_id()); 
                session.setAttribute("userNickname", member.getMb_nickname()); 

//                System.out.println("redirect URL : " + redirect);
                // 리다이렉트 URL 처리
                if (redirect != null && redirect.contains("/logout.do")) {
                    // 로그아웃 페이지로의 리다이렉트를 방지
                    session.removeAttribute("redirect");  // 혹시 세션에 저장된 redirect가 있으면 삭제
                    jsonResponse = "{\"code\": \"redirect\", \"url\": \"/main_view.do\"}";  // 기본 URL로 리다이렉트
                } else if (redirect != null && !redirect.isEmpty()) {
                    // 정상적인 리다이렉트 URL이 있는 경우
                    jsonResponse = "{\"code\": \"redirect\", \"url\": \"" + redirect + "\"}";
                } else {
                    // 리다이렉트 URL이 없거나 비어있는 경우 기본 경로로 리다이렉트
                    jsonResponse = "{\"code\": \"redirect\", \"url\": \"/main_view.do\"}";
                }

            } else if (mbState == 2) {
                // 탈퇴한 회원
                jsonResponse = "{\"code\": \"error\", \"desc\": \"로그인 할 수 없는 계정입니다. 관리자에게 문의해주세요.\"}";
            } else if (mbState == 3) {
                // 강퇴된 회원
                jsonResponse = "{\"code\": \"error\", \"desc\": \"로그인 할 수 없는 계정입니다. 관리자에게 문의해주세요.\"}";
            } else if (mbState == 4) {
                // 정지된 회원
                jsonResponse = "{\"code\": \"error\", \"desc\": \"로그인 할 수 없는 계정입니다. 관리자에게 문의해주세요.\"}";
            } else {
                // 알 수 없는 상태
                jsonResponse = "{\"code\": \"error\", \"desc\": \"알 수 없는 오류가 발생했습니다.\"}";
            }
        } else {
            jsonResponse = "{\"code\": \"error\", \"desc\": \"아이디 또는 비밀번호가 잘못되었습니다.\"}";
        }

        return jsonResponse;
    }
    
    @PostMapping("/checkSnsLoginEmail.do")
    public ResponseEntity<Map<String, String>> checkSnsLoginEmail(@RequestBody Map<String, String> params,
    															  HttpServletRequest request, HttpSession session) {
        String email = params.get("email");
        String redirect = params.get("redirect"); // redirect URL 가져오기
//        System.out.println("redirectUrl : " + redirect);
        
        MemberDto dto = memberDao.findById(email);  // 이메일로 회원 정보 조회
        Map<String, String> response = new HashMap<>();
        
        // 세션 초기화
        session.invalidate();  // 기존 세션 무효화
        session = request.getSession(true);  // 새로운 세션 생성
        
        if (dto != null) {
            int mbState = dto.getMb_state();  // 회원 상태 확인
            
            if (mbState == 1) {  // 정상 회원
                // SNS 계정으로 로그인된 경우 세션에 아이디, 닉네임 저장
                session.setAttribute("userId", dto.getMb_id());
                session.setAttribute("userNickname", dto.getMb_nickname()); // 닉네임 저장

                response.put("code", "exists");
                response.put("desc", "SNS 계정으로 로그인 되었습니다.");
                
//                System.out.println("redirect URL : " + redirect);
                // 리다이렉트 URL 처리
                if (redirect != null && redirect.contains("/logout.do")) {
                    // 로그아웃 페이지로의 리다이렉트를 방지하고 세션에 저장된 redirect 삭제
                    session.removeAttribute("redirect");
                    response.put("redirect", "/main_view.do");  // 기본 URL로 리다이렉트
                } else if (redirect != null && !redirect.isEmpty()) {
                    // 정상적인 리다이렉트 URL이 있는 경우
                    response.put("redirect", redirect);
                } else {
                    // 리다이렉트 URL이 없거나 비어있는 경우 기본 경로로 리다이렉트
                    response.put("redirect", "/main_view.do");
                }



            } else if (mbState == 2) {  // 탈퇴한 회원
                response.put("code", "withdrawn");
                response.put("desc", "로그인 할 수 없는 계정입니다. 관리자에게 문의해주세요.");

            } else if (mbState == 3) {  // 강퇴된 회원
                response.put("code", "banned");
                response.put("desc", "로그인 할 수 없는 계정입니다. 관리자에게 문의해주세요.");

            } else if (mbState == 4) {  // 정지된 회원
                response.put("code", "suspended");
                response.put("desc", "로그인 할 수 없는 계정입니다. 관리자에게 문의해주세요.");
            
            } else {
                response.put("code", "error");
                response.put("desc", "알 수 없는 오류가 발생했습니다.");
            }
        } else {
            // 회원이 존재하지 않음
            response.put("code", "not_found");
            response.put("desc", "SNS 계정과 연동된 이메일이 없습니다. 추가 정보 입력이 필요합니다.");
        }
        
        // API 키 추가
        response.put("googleClientId", DAILY_GOOGLE_KEY);
        response.put("kakaoClientId", DAILY_KAKAO_KEY);
        response.put("facebookAppId", DAILY_FB_KEY);

        return ResponseEntity.ok(response);
    }
    
    @RequestMapping("/findInfo.do")
    public String find(Model model) {
    	
    	model.addAttribute("kakaoKey", KAKAO_KEY);
    	
        return "find_info"; // find_info.jsp를 반환
    }

    @RequestMapping("/error1")
    	public String test1() {
    		//없는 페이지 호출
    		return "error1";
    }
    
    @RequestMapping("/test2")
	public String test2() {
		//에러나는 페이지 호출
		return "error-test";
    }
   
}

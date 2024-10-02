package com.study.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.service.QnAService;

@Controller
public class QnAController
{
	@Autowired
    private IQnADao qDao;
	private QnAService qService; 
	
	
	@GetMapping("/getMemberInfo/{mb_id}")
    public MemberDto getMemberInfo(@PathVariable("mb_id") String mb_id) {
        
		System.out.println("Requested Member ID: " + mb_id);
        
        // 회원 정보를 가져와서 출력
        MemberDto memberInfo = qService.getMemberById(mb_id);
        System.out.println("Member Info: " + memberInfo);
		
		return memberInfo;
    }
	
	@PostMapping("/submitQnA")
    public String submitQnA(@RequestBody QDto qDto,
    						@RequestParam int pdNum,
    						@RequestParam String mb_id) {
        
		//상품등록번호
		qDto.setQna_pnum(pdNum);
		
		//회원 이름
		String mb_name = qDao.getMemberNameById(mb_id);
		if (mb_name != null) {
	        qDto.setQna_name(mb_name);
	    } else {
	        return "회원 정보를 찾을 수 없습니다.";
	    }
	    
	    //공개 비공개
	    if (qDto.getQna_qstate() != null && qDto.getQna_qstate().equals("공개")) {
	        qDto.setQna_qstate("공개"); 
	    } else {
	        qDto.setQna_qstate("비공개"); 
	    }
        qDto.setQna_hide("N"); // 사용자가 선택한 옵션에 따라 설정
        qDto.setQna_rstate("N"); // 초기 상태

        // 데이터베이스에 Q&A 데이터 저장
        qDao.insertQnA(qDto);

        return "문의가 등록되었습니다.";
    }
	 
	 
	 
	 
}

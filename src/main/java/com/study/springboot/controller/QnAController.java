package com.study.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dto.QDto;

@Controller
public class QnAController
{
	@Autowired
    private IQnADao qDao;
	
	
	@PostMapping("/submitQnA")
    public String submitQnA(@RequestBody QDto qDto,
    						@RequestParam int pdNum) {
        
		//상품등록번호
		qDto.setQna_pnum(pdNum);
		
	    //공개 비공개
	    if (qDto.getQna_qstate() != null && qDto.getQna_qstate().equals("공개")) {
	        qDto.setQna_qstate("공개"); 
	    } else {
	        qDto.setQna_qstate("비공개"); 
	    }
        qDto.setQna_hide("N"); 
        qDto.setQna_rstate("N"); 

        // 데이터베이스에 Q&A 데이터 저장
        qDao.insertQnA(qDto);

        return "문의가 등록되었습니다.";
    }
	 
	 
	 
	 
}

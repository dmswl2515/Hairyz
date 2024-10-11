package com.study.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class QnAController
{
	@Autowired
    private IQnADao qDao;
	
	@Autowired
    private MemberService mService;
	
	
	@PostMapping("/submitQnA")
    public ResponseEntity<?> submitQnA(@RequestParam("content") String content,
            				@RequestParam("visibility") String visibility,
    						@RequestParam("productNum") Integer pdNum,
    						HttpSession session,
    						Model model) {
		String memberId = (String) session.getAttribute("userId");
		
		QDto qDto = new QDto();
		
		qDto.setQna_pnum(pdNum);
		qDto.setQna_authorId(memberId);
		qDto.setQna_content(content);
	    qDto.setQna_qstate(visibility);
        qDto.setQna_hide("N"); 
        qDto.setQna_rstate("N"); 
		
		if (memberId != null) {
        	MemberDto memberList = mService.getMemberByMemberId(memberId);
        	model.addAttribute("memberList", memberList);
        	
        	// 회원 이름을 가져와서 qDto의 qna_name에 설정
            qDto.setQna_name(memberList.getMb_name());
        	
        	System.out.println("memberName :" + memberList.getMb_name());
        } else {
        	System.out.println("Member ID is null");
        }
		
		System.out.println("pdNum :" + pdNum);
		System.out.println("content :" + qDto.getQna_content());
		System.out.println("qstate :" + qDto.getQna_qstate());

        // 데이터베이스에 Q&A 데이터 저장
        qDao.insertQnA(qDto);

        return ResponseEntity.ok().body("문의가 등록되었습니다.");
    }
	 
	 
	 
	 
}

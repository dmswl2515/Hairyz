package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dao.IQnaReplyDao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;

@Service
public class QnAService {
    
    
    @Autowired
    private IQnADao qnaDao;
    
    @Autowired
    private IQnaReplyDao qnaReplyDao;
    
    // 제품 번호에 해당하는 Q&A 목록을 가져오기	
    public List<QDto> getQnaByProductId(int pdNum) {
        
        List<QDto> qnaList = qnaDao.selectQnaByPdNum(pdNum);
		
        return qnaList;
    }
    
    //문의글에 대한 답변을 가져오기
    public List<QnaReplyDto> getAllQnaReplies() {
    	
        return qnaReplyDao.getAllQnaReplies();
    }

	public MemberDto getMemberById(String mb_id)
	{
		return qnaDao.findMemberById(mb_id);
	}
}

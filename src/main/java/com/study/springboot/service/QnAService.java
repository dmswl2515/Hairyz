package com.study.springboot.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;

@Service
public class QnAService {
    
    
    @Autowired
    private IQnADao qnaDao;
    
    public List<QDto> getQnaByProductId(int pdNum) {
        // 제품 번호에 해당하는 Q&A 목록을 가져옵니다.
        List<QDto> qnaList = qnaDao.selectQnaByPdNum(pdNum);
		
        return qnaList;
    }
    
    public List<QnaReplyDto> getQnaReplyByQnaNo(int qna_no) {
    	
    	if (qna_no <= 0) {
            return new ArrayList<>(); // qna_no가 유효하지 않으면 빈 리스트 반환
        }
    	
        // 제품 번호에 해당하는 Q&A 목록을 가져옵니다.
    	List<QnaReplyDto> qnaRepList = qnaDao.getQnaWithReplies(qna_no);
        return qnaRepList;
    }

	public MemberDto getMemberById(String mb_id)
	{
		return qnaDao.findMemberById(mb_id);
	}
}

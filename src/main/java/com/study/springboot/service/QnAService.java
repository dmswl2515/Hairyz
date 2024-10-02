package com.study.springboot.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dto.QDto;

@Service
public class QnAService {
    
    
    @Autowired
    private IQnADao qnaDao;
    
    public List<QDto> getQnaByProductId(int pdNum) {
        // 제품 번호에 해당하는 Q&A 목록을 가져옵니다.
        List<QDto> qnaList = qnaDao.selectQnaByPdNum(pdNum);
		
        return qnaList;
    }
}

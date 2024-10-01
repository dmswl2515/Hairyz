package com.study.springboot.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IQnADao;
import com.study.springboot.dto.QDTO;

@Service
public class QnAService {
    
    
    @Autowired
    private IQnADao qnaDao;
    
    public static final int NEW_QNA_PERIOD = 3;
    

    public List<QDTO> getQnaByProductId(int pdNum) {
        // 제품 번호에 해당하는 Q&A 목록을 가져옵니다.
        List<QDTO> qnaList = qnaDao.selectQnaByPdNum(pdNum);

        // 현재 날짜
        LocalDate today = LocalDate.now();

        // Q&A 목록을 스트림으로 처리하여 새 Q&A 여부를 설정합니다.
        return qnaList.stream().peek(item -> {
            Date qnaDate = item.getQna_date();
            if (qnaDate != null) {
                LocalDate qnaDateConverted = qnaDate.toInstant()
                                                     .atZone(ZoneId.systemDefault())
                                                     .toLocalDate();
                // Q&A 작성일이 현재 날짜와 NEW_QNA_PERIOD 일 이내인지 확인합니다.
                item.setNew(qnaDateConverted.plusDays(NEW_QNA_PERIOD).isAfter(today));
            } else {
                item.setNew(false);
            }
        }).collect(Collectors.toList());
    }
}

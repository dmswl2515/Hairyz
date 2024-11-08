package com.study.springboot.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IReplyDao;
import com.study.springboot.dto.ReplyDto;

@Service
public class ReplyService {
	
	@Autowired
    private IReplyDao replyDao;

	// 특정 게시글의 댓글 목록 가져오기
    public List<ReplyDto> getRepliesByBdNo(int bd_no) {
        return replyDao.getRepliesByBdNo(bd_no);
    }

    // 댓글 추가
    public boolean addReply(ReplyDto reply) {
        reply.setRp_date(new Date()); // 현재 날짜로 설정
        return replyDao.insertReply(reply) > 0;
    }

    // 댓글 삭제
    public boolean deleteReply(int rp_no) {
    	int result = replyDao.updateRpState(rp_no);
        return result > 0;
    }

    // 게시글의 댓글 개수 가져오기
    public int getReplyCount(int bd_no) {
        return replyDao.countReplies(bd_no);
    }
}

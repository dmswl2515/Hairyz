package com.study.springboot.service;

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
    public List<ReplyDto> getReplyByBoardId(int bd_no) {
        return replyDao.getReplyListByBoardId(bd_no);
    }

    // 댓글 추가
    public boolean addReply(ReplyDto reply) {
        return replyDao.insertReply(reply) > 0;
    }

    // 댓글 삭제
    public boolean deleteReply(int rp_no) {
        return replyDao.deleteReply(rp_no) > 0;
    }

    // 게시글의 댓글 개수 가져오기
    public int getReplyCount(int tb_no) {
        return replyDao.countReplies(tb_no);
    }
}

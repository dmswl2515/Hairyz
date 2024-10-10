package com.study.springboot.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.study.springboot.dto.ReplyDto;

@Mapper
public interface IReplyDao
{
	// 특정 게시글의 댓글 목록 가져오기
    List<ReplyDto> getReplyListByBoardId(int bd_no);

    // 댓글 추가
    int insertReply(ReplyDto reply);

    // 댓글 삭제
    int deleteReply(int rp_no);

    // 댓글 개수 가져오기
    int countReplies(int tb_no);
    
}

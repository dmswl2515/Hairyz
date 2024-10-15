package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.study.springboot.dto.QnaReplyDto;

@Mapper
public interface IQnaReplyDao
{
	public int insertQnaReply(int qna_no, String qr_id, String qr_content);
	
    List<QnaReplyDto> getAllQnaReplies();
}

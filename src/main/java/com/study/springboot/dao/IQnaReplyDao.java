package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IQnaReplyDao
{
	public int insertQnaReply(int qna_no, String qr_id, String qr_content);
}

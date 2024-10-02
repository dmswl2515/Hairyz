package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;

@Mapper
public interface IQnADao
{
	List<QDto> selectQnaByPdNum(@Param("pdNum") int pdNum);

	public List<QnaReplyDto> getQnaWithReplies(@Param("qna_no") int qna_no);
}

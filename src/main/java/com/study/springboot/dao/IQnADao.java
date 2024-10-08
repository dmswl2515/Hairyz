package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;

@Mapper
public interface IQnADao
{	
	//상품 번호로 문의내용 가져오기
	List<QDto> selectQnaByPdNum(@Param("pdNum") int pdNum);
	
	//문의 번호로 답변 가져오기
	public List<QnaReplyDto> getQnaWithReplies(@Param("qna_no") int qna_no);
	
	void insertQnA(QDto qDto);

	String getMemberNameById(String mb_id);
	
	MemberDto findMemberById(String mb_id);
	
}

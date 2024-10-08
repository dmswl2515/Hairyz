package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.AdminDto;
import com.study.springboot.dto.QDto;

@Mapper
public interface IAdminDao
{
   
    // 관리자 로그인
	public AdminDto findById(String id);
	
	//전체 답변 가져오기
	public List<QDto> getAllQna();
	
}

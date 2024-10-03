package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.AdminDto;

@Mapper
public interface IAdminDao
{
   
    // 관리자 로그인
	public AdminDto findById(String id);
	
}

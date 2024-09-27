package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.MemberDto;

@Mapper
public interface IMemberDao
{
	public MemberDto selectMember(String id);
	public int updateProfile(String id, String nickname, String phone, int zipcode, String addr1, String addr2);
	public int updatePw(String id, String pw);
}

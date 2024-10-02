package com.study.springboot.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.MemberDto;

@Mapper
public interface IMemberDao
{
	public MemberDto selectMember(String id);
	public int updateProfile(String id, String nickname, String phone, String zipcode, String addr1, String addr2, String orgname, String modname, String imgpath);
	public int updatePw(String id, String pw);
	public int updateState(String id, int state);
	public MemberDto selectMember2(int mb_no);
	
	// 이메일 중복 확인
    int checkEmailExists(String email);
    
    // 회원가입 처리
    int insertMember(Map<String, String> paramMap);
}

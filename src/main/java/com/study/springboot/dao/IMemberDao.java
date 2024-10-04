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
    
    // 로그인, SNS로그인
	public MemberDto findById(String id);
	
	// 아이디/비밀번호 찾기
	public String findEmailByPhone(String phone);
	public String findPwById(String id);
	
}

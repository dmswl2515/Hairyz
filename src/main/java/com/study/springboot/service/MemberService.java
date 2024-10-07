package com.study.springboot.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dto.MemberDto;

@Service
public class MemberService {

    @Autowired
    private IMemberDao memberDao;

    public int registerMember(Map<String, String> paramMap) {
        return memberDao.insertMember(paramMap);
    }

    public boolean isEmailExists(String email) {
        int count = memberDao.checkEmailExists(email);
        return count > 0; // 0보다 크면 이메일이 존재함
    }

    public boolean validateLogin(String id, String pw) {
        //MemberDto member = memberDao.findById(id);
        MemberDto dto = memberDao.selectMember(id);
        
        if (dto != null && dto.getMb_pw().equals(pw)) {
            return true;
        } else {
            return false;
        }
    }

	public MemberDto getMemberByMemberId(String memberId) {
		
		return memberDao.findById(memberId);
	}

}

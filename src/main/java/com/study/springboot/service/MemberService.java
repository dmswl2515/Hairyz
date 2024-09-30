package com.study.springboot.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IMemberDao;

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
}

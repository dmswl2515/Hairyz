package com.study.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IAdminDao;
import com.study.springboot.dto.AdminDto;

@Service
public class AdminService {

    @Autowired
    private IAdminDao adminDao;

    public boolean validateLogin(String id, String pw) {
        //MemberDto member = memberDao.findById(id);
        AdminDto dto = adminDao.findById(id);
        
        if (dto != null && dto.getAdmin_pw().equals(pw)) {
            return true;
        } else {
            return false;
        }
    }

}

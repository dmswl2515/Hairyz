package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IAdminDao;
import com.study.springboot.dto.AdminDto;
import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;

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
    
    public List<QDto> getAllQna() {
        return adminDao.getAllQna();
    }

	public List<BoardDto> getAllCommunityContent() {
		return adminDao.getAllCommunityContent();
	}

	
	public boolean hidePosts(List<Integer> bdNos) {
		
		try {
			adminDao.updateBdStateToHidden(bdNos);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
	}

}

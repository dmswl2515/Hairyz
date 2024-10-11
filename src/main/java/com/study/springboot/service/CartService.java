package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.ICartDao;
import com.study.springboot.dto.CartDto;

@Service
public class CartService {
    
    
    @Autowired
    private ICartDao cartDao;
    
    public List<CartDto> getCartByMemberId(String memberId) {
        return cartDao.getCartByMemberId(memberId); 
    }
	
    public boolean deleteSelectedProducts(List<Integer> pdNums) {
        try {
            // Mapper 호출
        	cartDao.deleteProducts(pdNums);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<CartDto> findCartItemByMemberIdAndProductId(String mbId, Integer pdNum) {
        return cartDao.findCartItemByMemberIdAndProductId(mbId, pdNum);
    }

}

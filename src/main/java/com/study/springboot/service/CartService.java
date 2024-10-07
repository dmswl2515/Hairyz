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
}

package com.study.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IOrdersDao;
import com.study.springboot.dto.OrdersDto;

@Service
public class OrdersService {
	
	@Autowired
    private IOrdersDao ordersDao;

    // 주문 정보 저장
    public void insertOrder(OrdersDto ordersDto) {
    	ordersDao.insertOrder(ordersDto);
    }
}

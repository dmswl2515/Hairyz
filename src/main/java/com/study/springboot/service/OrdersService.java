package com.study.springboot.service;

import java.sql.SQLException;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IOrdersDao;
import com.study.springboot.dto.OrdersDto;

@Service
public class OrdersService {
	
	@Autowired
    private IOrdersDao ordersDao;

	public Integer generateUniqueOrderNumber() throws SQLException {
        Random random = new Random();
        Integer orderNumber;

        do {
            orderNumber = random.nextInt(1_000_000_000); // 0 ~ 999999999 사이의 랜덤 숫자
            // 숫자를 10자리로 맞추기 위해 필요시 앞에 0을 추가
            String orderStr = String.format("%010d", orderNumber);
            orderNumber = Integer.valueOf(orderStr); // 10자리로 변환하여 Integer로 저장
        } while (ordersDao.orderNumberExists(orderNumber)); // 중복 체크

        return orderNumber;
    }
    
	// 주문 정보 저장
    public void insertOrder(OrdersDto ordersDto) {
    	ordersDao.insertOrder(ordersDto);
    }
    
    
}

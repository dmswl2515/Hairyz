package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.OrdersDto;

@Mapper
public interface IOrdersDao {
	
	// 주문 정보 저장
    void insertOrder(OrdersDto ordersDto);
    
}

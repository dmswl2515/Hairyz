package com.study.springboot.dao;


import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.OrdersDto;

@Mapper
public interface IOrdersDao
{
    void insertOrder(OrdersDto ordersDto);

	boolean orderNumberExists(Integer orderNumber);
	
	public OrdersDto selectOrders(int od_no);

	
}

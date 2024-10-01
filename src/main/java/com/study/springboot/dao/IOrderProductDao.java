package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.OrderProductDto;

@Mapper
public interface IOrderProductDao
{
	public List<OrderProductDto> selectOrderProduct(int od_mno);
	public int updateState(int od_no, String od_state);
	
}

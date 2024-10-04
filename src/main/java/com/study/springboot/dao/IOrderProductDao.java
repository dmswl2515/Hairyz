package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.OrderProductDto;
import com.study.springboot.dto.PageDto;

@Mapper
public interface IOrderProductDao
{
	public List<OrderProductDto> selectOrderProduct(int od_mno);
	public int updateState(int od_no, String od_state);
	public int insertProductRevie(int pr_productId, int pr_MbNum, String pr_MbNnme, int pr_rating, String pr_reviewText, String pr_imgPath, String pr_orgName, String pr_modName);
	public List<OrderProductDto> selectReturnExchange(int od_mno);
	public PageDto orderTotal();
	public List<OrderProductDto> selectPageSalesM(int startRow, int endRow);
	
}

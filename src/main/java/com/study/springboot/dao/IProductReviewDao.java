package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.PageDto;
import com.study.springboot.dto.ProductReviewDto;

@Mapper
public interface IProductReviewDao
{
	public List<ProductReviewDto> selectReview(int endRow, int startRow);
	public PageDto reviewTotal();
	
}

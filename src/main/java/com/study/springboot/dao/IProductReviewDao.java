package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.study.springboot.dto.PageDto;
import com.study.springboot.dto.ProductReviewDto;

@Mapper
public interface IProductReviewDao
{	
	// 제품 ID로 리뷰 조회
	List<ProductReviewDto> getReviewsByProductId(@Param("productId") int productId); 


	public List<ProductReviewDto> selectReview(int endRow, int startRow);
	public PageDto reviewTotal();
	public int updateHasReply(int pr_reviewId, String pr_hasReply);
	
}

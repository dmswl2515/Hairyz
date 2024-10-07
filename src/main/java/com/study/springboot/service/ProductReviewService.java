package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IProductReviewDao;
import com.study.springboot.dto.ProductReviewDto;

@Service
public class ProductReviewService
{
	@Autowired
    private IProductReviewDao PRDao;
	
	public List<ProductReviewDto> getReviewsByProductId(int productId) {
        return PRDao.getReviewsByProductId(productId);
    }
}

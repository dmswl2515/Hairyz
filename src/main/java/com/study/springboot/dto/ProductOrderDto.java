package com.study.springboot.dto;

import lombok.Data;

@Data
public class ProductOrderDto
{
	private Integer pdNum;      // 상품 번호
    private Integer pdQuantity;  // 상품 수량
}

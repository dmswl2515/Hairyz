package com.study.springboot.dto;

import lombok.Data;

@Data
public class CartDto
{
	private int sbagNo;      // 장바구니 번호
    private String mbId;     // 회원 고유번호
    private int pdNum;      // 상품 등록번호
    private int sbagAmount;  // 선택 수량
    private int sbagPrice;  // 주문금액
    private String pdChngFname; // 상품 이미지 파일명
    private String pdName;    // 상품 이름
    private int pdPrice;
    
}

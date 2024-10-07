package com.study.springboot.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrdersDto {
	
	private Integer odNo;           // 주문 번호
    private Integer odMno;          // 회원 고유번호
    private Date odDate;  // 주문 일자
    private Integer odNum;          // 상품 등록번호
    private Integer odAmount;       // 주문한 상품 수량
    private String odMname;         // 주문자 이름
    private String odMphone;        // 주문자 연락처
    private String odMemail;        // 주문자 이메일
    private String odRecipient;      // 수령인
    private String odRphone;        // 수령인 연락처
    private String odRzcode;        // 수령인 우편번호
    private String odRaddress;      // 수령인 주소
    private String odRaddress2;     // 수령인 상세주소
    private String odMemo;          // 배송 메모
    private String odMethod;        // 결제 수단
    private char odPayment;       // 결제 여부 (Y/N)
    private String odState;         // 상품 주문 상태
}
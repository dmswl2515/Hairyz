package com.study.springboot.dto;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderProductDto
{
	private int orderno; // 주문 번호
	private Timestamp orderdate; // 주문 날짜
	private int orderamount; // 주문 수량
	private String membername; // 주문자 이름
	private String memberphone; // 주문자 전화번호
	private String memberemail; // 주문자 이메일
	private String recipientname; // 수령인 이름
	private String recipientphone; // 수령인 전화번호
	private String recipientzipcode; // 우편번호
	private String recipientaddress; // 주소
	private String recipientaddress2; // 상세 주소
	private String memo; // 메모
	private String method; // 결제 방법
	private char payment; // 결제 상태
	private String state; // 주문 상태
	private String productname; // 상품명
	private int productprice; // 상품 가격
	private String originalfilename; // 원본 파일 이름
	private String changedfilename; // 변경된 파일 이름
	private String filePath; // 파일 경로

}

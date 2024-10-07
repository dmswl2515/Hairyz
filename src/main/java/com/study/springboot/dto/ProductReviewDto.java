package com.study.springboot.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ProductReviewDto
{
	private int reviewId;           // 리뷰번호
    private int productId;          // 제품번호
    private int mbNum;              // 유저번호
    private String mbName;          // 작성자
    private int rating;             // 별점
    private String reviewText;      // 리뷰 내용
    private Date reviewDate;        // 리뷰 작성 날짜
    private char hasReply;          // 답글 여부
    private String imgPath;         // 이미지 경로
    private String orgName;         // 이미지 파일 원본 이름
    private String modName;         // 변경된 파일 이름
    private char visibility;         // 노출 여부

}

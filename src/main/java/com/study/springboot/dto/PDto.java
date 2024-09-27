package com.study.springboot.dto;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;

@Data
@Entity(name = "product")
public class PDto
{	
	@Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "product_seq") // 시퀀스 설정
    @SequenceGenerator(name = "product_seq", sequenceName = "product_seq", allocationSize = 1) // 시퀀스 이름
    private Integer pd_no; // 상품 번호 (PK)

    @Column(unique = true)
    private Integer pd_num; // 상품 등록번호

    private String pd_name; // 상품명

    private String pd_category; // 카테고리 (사료/간식/용품/기타)

    private String pd_animal; // 반려동물 종 (개/고양이)

    private Integer pd_price; // 상품 금액

    private Integer pd_amount; // 상품 수량

    private Integer pd_fee; // 배송비

    private Character pd_selling; // 상품 판매상태 (Y/N)

    @Temporal(TemporalType.DATE)
    private Date pd_rdate; // 상품 등록일

    private Integer pd_fnum; // 파일 번호

    private String pd_ori_fname; // 파일 원본이름(상품)

    private String pd_chng_fname; // 변경된 파일 이름(상품)

    @Temporal(TemporalType.DATE)
    private Date pd_fdate; // 파일 등록일(상품)

    private String pd_fpath; // 저장된 파일 경로(상품)

    private String pd_fsize; // 파일 크기(상품)
    
    private String pd_ori_fname2; // 파일 원본이름(상세)

    private String pd_chng_fname2; // 변경된 파일 이름(상세)

    @Temporal(TemporalType.DATE)
    private Date pd_fdate2; // 파일 등록일(상세)

    private String pd_fpath2; // 저장된 파일 경로(상세)

    private String pd_fsize2; // 파일 크기(상세)
    
    
    
}

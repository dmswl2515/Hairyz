package com.study.springboot.dto;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;

@Data
@Entity
@Table(name = "product")
public class PDto
{	
	@Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "product_seq") // 시퀀스 설정
    @SequenceGenerator(name = "product_seq", sequenceName = "product_seq", allocationSize = 1) // 시퀀스 이름
    private Integer pd_no; // 상품 번호 (PK)

    @Column(name="pd_num")
    private Integer pdNum; // 상품 등록번호
    
    @Column(name = "pd_name")
    private String pdName; // 상품명
    
    @Column(name = "pd_category")
    private String pdCategory; // 카테고리 (사료/간식/용품/리빙)
    
    @Column(name = "pd_animal")
    private String pdAnimal; // 반려동물 종 (개/고양이)

    private Integer pd_price; // 상품 금액

    private Integer pd_amount; // 상품 수량

    private Integer pd_fee; // 배송비

    private Character pd_selling; // 상품 판매상태 (Y/N)

    @Temporal(TemporalType.DATE)
    @Column(name = "pd_rdate")
    private Date pdRdate; // 상품 등록일

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
    
    

	public PDto()
	{
		super();
	}

	public PDto(Integer pd_no, Integer pdNum, String pdName, String pdCategory, String pdAnimal, Integer pd_price,
			Integer pd_amount, Integer pd_fee, Character pd_selling, Date pdRdate, Integer pd_fnum,
			String pd_ori_fname, String pd_chng_fname, Date pd_fdate, String pd_fpath, String pd_fsize,
			String pd_ori_fname2, String pd_chng_fname2, Date pd_fdate2, String pd_fpath2, String pd_fsize2)
	{
		super();
		this.pd_no = pd_no;
		this.pdNum = pdNum;
		this.pdName = pdName;
		this.pdCategory = pdCategory;
		this.pdAnimal = pdAnimal;
		this.pd_price = pd_price;
		this.pd_amount = pd_amount;
		this.pd_fee = pd_fee;
		this.pd_selling = pd_selling;
		this.pdRdate = pdRdate;
		this.pd_fnum = pd_fnum;
		this.pd_ori_fname = pd_ori_fname;
		this.pd_chng_fname = pd_chng_fname;
		this.pd_fdate = pd_fdate;
		this.pd_fpath = pd_fpath;
		this.pd_fsize = pd_fsize;
		this.pd_ori_fname2 = pd_ori_fname2;
		this.pd_chng_fname2 = pd_chng_fname2;
		this.pd_fdate2 = pd_fdate2;
		this.pd_fpath2 = pd_fpath2;
		this.pd_fsize2 = pd_fsize2;
	}

	public Integer getPd_no()
	{
		return pd_no;
	}

	public void setPd_no(Integer pd_no)
	{
		this.pd_no = pd_no;
	}

	public Integer getPdNum()
	{
		return pdNum;
	}

	public void setPdNum(Integer pdNum)
	{
		this.pdNum = pdNum;
	}

	public String getPdName()
	{
		return pdName;
	}

	public void setPdName(String pdName)
	{
		this.pdName = pdName;
	}

	public String getPdCategory()
	{
		return pdCategory;
	}

	public void setPdCategory(String pdCategory)
	{
		this.pdCategory = pdCategory;
	}

	public String getPdAnimal()
	{
		return pdAnimal;
	}

	public void setPdAnimal(String pdAnimal)
	{
		this.pdAnimal = pdAnimal;
	}

	public Integer getPd_price()
	{
		return pd_price;
	}

	public void setPd_price(Integer pd_price)
	{
		this.pd_price = pd_price;
	}

	public Integer getPd_amount()
	{
		return pd_amount;
	}

	public void setPd_amount(Integer pd_amount)
	{
		this.pd_amount = pd_amount;
	}

	public Integer getPd_fee()
	{
		return pd_fee;
	}

	public void setPd_fee(Integer pd_fee)
	{
		this.pd_fee = pd_fee;
	}

	public Character getPd_selling()
	{
		return pd_selling;
	}

	public void setPd_selling(Character pd_selling)
	{
		this.pd_selling = pd_selling;
	}

	public Date getPdRdate()
	{
		return pdRdate;
	}

	public void setPdRdate(Date pdRdate)
	{
		this.pdRdate = pdRdate;
	}

	public Integer getPd_fnum()
	{
		return pd_fnum;
	}

	public void setPd_fnum(Integer pd_fnum)
	{
		this.pd_fnum = pd_fnum;
	}

	public String getPd_ori_fname()
	{
		return pd_ori_fname;
	}

	public void setPd_ori_fname(String pd_ori_fname)
	{
		this.pd_ori_fname = pd_ori_fname;
	}

	public String getPd_chng_fname()
	{
		return pd_chng_fname;
	}

	public void setPd_chng_fname(String pd_chng_fname)
	{
		this.pd_chng_fname = pd_chng_fname;
	}

	public Date getPd_fdate()
	{
		return pd_fdate;
	}

	public void setPd_fdate(Date pd_fdate)
	{
		this.pd_fdate = pd_fdate;
	}

	public String getPd_fpath()
	{
		return pd_fpath;
	}

	public void setPd_fpath(String pd_fpath)
	{
		this.pd_fpath = pd_fpath;
	}

	public String getPd_fsize()
	{
		return pd_fsize;
	}

	public void setPd_fsize(String pd_fsize)
	{
		this.pd_fsize = pd_fsize;
	}

	public String getPd_ori_fname2()
	{
		return pd_ori_fname2;
	}

	public void setPd_ori_fname2(String pd_ori_fname2)
	{
		this.pd_ori_fname2 = pd_ori_fname2;
	}

	public String getPd_chng_fname2()
	{
		return pd_chng_fname2;
	}

	public void setPd_chng_fname2(String pd_chng_fname2)
	{
		this.pd_chng_fname2 = pd_chng_fname2;
	}

	public Date getPd_fdate2()
	{
		return pd_fdate2;
	}

	public void setPd_fdate2(Date pd_fdate2)
	{
		this.pd_fdate2 = pd_fdate2;
	}

	public String getPd_fpath2()
	{
		return pd_fpath2;
	}

	public void setPd_fpath2(String pd_fpath2)
	{
		this.pd_fpath2 = pd_fpath2;
	}

	public String getPd_fsize2()
	{
		return pd_fsize2;
	}

	public void setPd_fsize2(String pd_fsize2)
	{
		this.pd_fsize2 = pd_fsize2;
	}
	
	
    
    
}

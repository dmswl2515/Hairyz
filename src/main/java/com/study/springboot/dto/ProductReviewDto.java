package com.study.springboot.dto;


import java.sql.Timestamp;
import lombok.Data;

@Data
public class ProductReviewDto
{

	private int pr_reviewId;
	private int pr_productId;
	private int pr_MbNum;
	private String pr_MbNnme;
	private int pr_rating;
	private String pr_reviewText;
	private Timestamp pr_reviewDate;
	private String pr_hasReply;
	private String pr_imgPath;
	private String pr_orgName;
	private String pr_modName;
	private String pr_visibility;

}

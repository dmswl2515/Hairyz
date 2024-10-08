package com.study.springboot.dto;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewReplyDto
{
	private int rrp_no;
	private int pr_reviewId;
	private String rrp_id;
	private String rrp_content;
	private Timestamp rrp_date;

}

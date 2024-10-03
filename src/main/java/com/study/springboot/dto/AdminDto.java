package com.study.springboot.dto;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class AdminDto
{
	private int admin_no;
	private String admin_id;
	private String admin_pw;
	private String admin_name;
	private Timestamp admin_createdAt;

}

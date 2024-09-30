package com.study.springboot.dto;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberDto
{
	private int mb_no;
	private String mb_sns;
	private String mb_id;
	private String mb_pw;
	private String mb_name;
	private String mb_nickname;
	private String mb_phone;
	private String mb_zipcode;
	private String mb_addr1;
	private String mb_addr2;
	private int mb_state;
	private String mb_orgname;
	private String mb_modname;
	private String mb_imgpath;
	private Timestamp mb_joindate;
	private Timestamp mb_withdraw;

}

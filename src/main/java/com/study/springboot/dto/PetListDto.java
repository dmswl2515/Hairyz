package com.study.springboot.dto;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class PetListDto
{
	private int pl_id;
	private String pl_name;
	private int pl_mbNum;
	private Timestamp pl_birth;
	private String pl_pettype;
	private String pl_breed;
	private String pl_gender;
	private double pl_weight;
	private Timestamp pl_date;
	private String pl_imgPath;
	private String pl_orgName;
	private String pl_modName;

}

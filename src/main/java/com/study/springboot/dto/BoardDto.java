package com.study.springboot.dto;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardDto {
    private int bd_no;
    private String bd_cate;
    private String bd_writer;
    private String bd_title;
    private String bd_content;
    private int bd_hit;
    private int bd_like;
    private Timestamp bd_date;
    private String bd_imgpath;
    private String bd_orgname;
    private String bd_modname;
    private String bd_state;
}

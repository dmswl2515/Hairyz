package com.study.springboot.dto;

import java.util.Date;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReplyDto {
	private int rp_no;
    private int bd_no;
    private String mb_id;
    private String rp_writer;
    private String rp_content;
    private Date rp_date;
    private String rp_state;
}

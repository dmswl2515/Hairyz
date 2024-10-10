package com.study.springboot.dto;
import java.util.Date;
import lombok.Data;

@Data
public class QDto
{	
	private int qna_no;
    private int qna_pnum;
    private String qna_authorId;
    private String qna_name;
    private Date qna_date;
    private String qna_content;
    private String qna_qstate;
    private String qna_hide;
    private String qna_rstate;
    
    // isNew 필드 정의
    private boolean isNew;
    
    public boolean isNew() {
        return qna_date != null && (System.currentTimeMillis() - qna_date.getTime()) < (3 * 24 * 60 * 60 * 1000);
    }

	
}

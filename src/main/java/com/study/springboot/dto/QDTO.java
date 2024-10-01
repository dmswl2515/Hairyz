package com.study.springboot.dto;
import java.util.Date;
import lombok.Data;

@Data
public class QDTO
{	
	private int qna_no;
    private int qna_pnum;
    private String qna_name;
    private Date qna_date;
    private String qna_content;
    private String qna_qstate;
    private String qna_hide;
    private String qna_rstate;
    
    // isNew 필드 정의
    private boolean isNew; // 

    // getter 메서드
    public boolean isNew() {
        return isNew;
    }

    // setter 메서드
    public void setNew(boolean isNew) {
        this.isNew = isNew;
    }

}

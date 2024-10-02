package com.study.springboot.dto;
import java.util.Date;
import lombok.Data;

@Data
public class QnaReplyDto {
    private Integer qrNo;        // 답변 고유 번호
    private Integer qnaNo;       // QnA 본문 고유번호
    private String qrId;       	 // 관리자 아이디
    private String qrContent;    // 답변 내용
    private Date qrDate;         // 답변 등록일
}

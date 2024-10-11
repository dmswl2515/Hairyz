package com.study.springboot.dto;

import java.util.Date;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardDto {
    private int bd_no;                // 게시글 고유 번호
    private String bd_cate;           // 카테고리(자유 f / 질문 q)
    private String mb_id;       	  // 작성자 아이디
    private String bd_writer;         // 작성자 닉네임
    private String bd_title;          // 글 제목
    private String bd_content;        // 본문 내용
    private int bd_hit = 0;           // 조회수, 기본값 0
    private int bd_like = 0;          // 좋아요 수, 기본값 0
    private Date bd_date;             // 등록일
    private String bd_imgpath;        // 이미지 경로
    private String bd_orgname;        // 이미지 파일 원본 이름
    private String bd_modname;        // 변경된 파일 이름
    private String bd_state;          // 노출 상태(Y/N)
}

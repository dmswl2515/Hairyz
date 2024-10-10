package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.BoardDto;

@Mapper
public interface IBoardDao
{
    // 글쓰기
    int insertPost(BoardDto boardDto);

    // 특정 게시글 가져오기
    BoardDto getPostView(int bd_no);

    // 게시글 조회수 증가
    int upHit(int bd_no);

    // 게시글 목록 가져오기 (카테고리별)
    List<BoardDto> getBoardListByCategory(String bd_cate);
    
}

package com.study.springboot.dao;

import com.study.springboot.dto.BoardDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBoardDao
{
    // 글쓰기
    int insertPost(BoardDto boardDto);
    
}

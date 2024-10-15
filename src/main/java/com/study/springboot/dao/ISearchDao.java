package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.PDto;

@Mapper	
public interface ISearchDao
{

//	// 상품 검색 메소드
//	List<PDto> findProductsByKeyword(@Param("sKeyword") String sKeyword);

    // 게시판 검색 메소드
	List<BoardDto> findBoardsByKeyword(@Param("sKeyword") String sKeyword);
}

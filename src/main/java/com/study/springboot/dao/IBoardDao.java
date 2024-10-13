package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

    // 좋아요 추가
    int insertLike(@Param("userId") String userId, @Param("boardId") int boardId);

    // 좋아요 삭제
    int deleteLike(@Param("userId") String userId, @Param("boardId") int boardId);

    // 특정 게시글의 좋아요 수 조회
    int getLikeCount(@Param("boardId") int boardId);

    // 사용자가 특정 게시글에 좋아요를 눌렀는지 확인
    int checkUserLike(@Param("userId") String userId, @Param("boardId") int boardId);

	int deletePost(int bd_no);

	// 수정할 게시글 조회
	BoardDto getPostById(int bd_no);

	int updatePost(BoardDto boardDto);
    
}

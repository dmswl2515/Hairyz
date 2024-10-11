package com.study.springboot.service;

import com.study.springboot.dao.IBoardDao;
import com.study.springboot.dto.BoardDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

    @Autowired
    private IBoardDao boardDao;

    public void writePost(BoardDto boardDto) {
        boardDao.insertPost(boardDto);
    }

    // 특정 게시글 가져오기
    public BoardDto getPostView(int bd_no) {
        // 조회수 증가
        boardDao.upHit(bd_no);
        return boardDao.getPostView(bd_no);
    }

    // 좋아요 토글 처리
    public int toggleLike(String userId, int boardId) {
        // 사용자가 이미 좋아요를 눌렀는지 확인
        int userLikeCount = boardDao.checkUserLike(userId, boardId);
        
        if (userLikeCount > 0) {
            // 이미 눌렀으면 좋아요 삭제 (좋아요 취소)
        	boardDao.deleteLike(userId, boardId);
        } else {
            // 좋아요 추가
        	boardDao.insertLike(userId, boardId);
        }

        // 게시글의 현재 좋아요 수 리턴
        return boardDao.getLikeCount(boardId);
    }

    // 특정 게시글의 좋아요 수 조회
    public int getLikeCount(int boardId) {
        return boardDao.getLikeCount(boardId);
    }
    
 // 사용자가 특정 게시글에 대해 좋아요를 눌렀는지 확인
    public boolean checkUserLike(String userId, int boardId) {
        // 사용자 좋아요 수를 조회하여 0보다 큰지 확인
        return boardDao.checkUserLike(userId, boardId) > 0;
    }

}

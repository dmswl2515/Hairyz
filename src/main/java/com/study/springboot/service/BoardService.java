package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IBoardDao;
import com.study.springboot.dto.BoardDto;

@Service
public class BoardService {

    @Autowired
    private IBoardDao boardDao;

    public int writePost(BoardDto boardDto) {
        boardDao.insertPost(boardDto);
        return boardDto.getBd_no();
    }

    // 특정 게시글 가져오기
    public BoardDto getPostView(int bd_no, String userId) {
    	// 게시글 정보 조회
        BoardDto board = boardDao.getPostView(bd_no);
        
        // 작성자와 세션 사용자 ID 비교
        if (!board.getMb_id().equals(userId)) {
            // 작성자가 아닌 경우 조회수 증가
            boardDao.upHit(bd_no);
        }
        
        return board;
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

	public boolean deletePost(int bd_no) {
		return boardDao.deletePost(bd_no) > 0; // DAO 호출하여 삭제 성공 여부 반환
	}
	
	public BoardDto getPostById(int bd_no) {
        return boardDao.getPostById(bd_no);
    }

	public int updatePost(BoardDto boardDto) {
        return boardDao.updatePost(boardDto);
	}

	public int getBoardCount(String category, String condition, String keyword) {
		return boardDao.getBoardCount(category, condition, keyword);
	}
	
	public List<BoardDto> getBoardList(int page, int pageSize, String category, String condition, String keyword) {
        int startRow = (page - 1) * pageSize;
        int endRow = startRow + pageSize;
        
        // 파라미터 값 출력
//        System.out.println("Page: " + page);
//        System.out.println("Page Size: " + pageSize);
//        System.out.println("Category: " + category);
//        System.out.println("Condition: " + condition);
//        System.out.println("Keyword: " + keyword);
//        System.out.println("startRow: " + startRow);
//        System.out.println("endRow: " + endRow);
//        System.out.println("category(service): " + category);
        
        if (condition == null || condition.trim().isEmpty()) {
            condition = null;
        }
        if (keyword == null || keyword.trim().isEmpty()) {
            keyword = null;
        }
        
        // DAO를 통해 게시글 리스트를 가져옴
        List<BoardDto> boardList = boardDao.getBoardList(startRow, endRow, pageSize, category, condition, keyword);

        // 이미지 태그 제거 로직 추가
        for (BoardDto board : boardList) {
            String content = board.getBd_content();
            String contentWithoutImages = removeImgTags(content);  // 이미지 태그 제거
            
            board.setBd_content_delimg(contentWithoutImages);  // 수정된 내용 설정
        }

        return boardList;
    }
	
	// 정규식을 사용해 <img> 태그를 제거하는 메서드
    private String removeImgTags(String content) {
        if (content == null) {
            return null;
        }

        // <img><br> 태그를 정규식으로 모두 제거
        return content.replaceAll("(?i)<img[^>]*>(\\s*<br\\s*/?>)?", "<!--IMG_REMOVED-->");
    }

}

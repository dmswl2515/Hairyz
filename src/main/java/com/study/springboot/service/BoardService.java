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

}

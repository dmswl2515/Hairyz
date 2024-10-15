package com.study.springboot.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.ISearchDao;
import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.PDto;

@Service
public class SearchService {
    
    
    @Autowired
    private ISearchDao searchDao;

//    public List<PDto> getProductsByKeyword(String sKeyword) {
//        return searchDao.findProductsByKeyword(sKeyword);
//    }
    
    public List<BoardDto> getBoardsByKeyword(String sKeyword) {
        return searchDao.findBoardsByKeyword(sKeyword);
    }
    
}

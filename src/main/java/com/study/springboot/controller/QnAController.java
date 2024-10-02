package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.study.springboot.dto.QDto;
import com.study.springboot.service.QnAService;

@Controller
public class QnAController
{
	 @Autowired
	    private QnAService qnaService;
	 
	 
}

package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.QDTO;

@Mapper
public interface IQnADao
{
	List<QDTO> selectQnaByPdNum(@Param("pdNum") int pdNum);
}

package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.PetListDto;

@Mapper
public interface IPetListDao
{
	public int insertPet(String name, String mbNum, String birth, String pettype, String breed, String gender, double weigth, String imgPath, String orgNamem, String modName);
	public List<PetListDto> petList(int mbNum);
}

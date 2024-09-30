package com.study.springboot.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.PDto;

@Repository
public interface PRepository extends JpaRepository<PDto, Integer>
{
	List<PDto> findAll();
	
	List<PDto> findByPdNum(Integer pdNum); // 상품 번호로 검색
    List<PDto> findByPdNameContaining(String pdName);
    
    
    
}




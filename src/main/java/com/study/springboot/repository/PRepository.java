package com.study.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.PDto;

@Repository
public interface PRepository extends JpaRepository<PDto, Integer>
{
	List<PDto> findAll();
	
	List<PDto> findByPdNum(Integer pdNum); // 상품 번호로 검색
    List<PDto> findByPdNameContaining(String pdName);
    
    @Query(value = "SELECT * FROM ( SELECT p.*, ROW_NUMBER() OVER (ORDER BY pd_num) AS rn FROM product p ) WHERE rn BETWEEN :startRow AND :endRow", nativeQuery = true)
    List<PDto> findPaginated(@Param("startRow") int startRow, @Param("endRow") int endRow);
    
    
}




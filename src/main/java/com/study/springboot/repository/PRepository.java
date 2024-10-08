package com.study.springboot.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.PDto;

@Repository
public interface PRepository extends JpaRepository<PDto, Integer>
{
	List<PDto> findAll();
	
	// 상품 번호로 상품 검색
	List<PDto> findByPdNum(Integer pdNum); 
    List<PDto> findByPdNameContaining(String pdName);
    
    @Query(value = "SELECT * FROM ( SELECT p.*, ROW_NUMBER() OVER (ORDER BY pd_num) AS rn FROM product p ) WHERE rn BETWEEN :startRow AND :endRow", nativeQuery = true)
    List<PDto> findPaginated(@Param("startRow") int startRow, @Param("endRow") int endRow);

    @Query(value = "SELECT * FROM ( SELECT p.*, ROW_NUMBER() OVER (ORDER BY pd_num) AS rn FROM product p WHERE pd_animal = :pd_animal ) WHERE rn BETWEEN :startRow AND :endRow", nativeQuery = true)
    List<PDto> findByPdAnimal(@Param("pd_animal") String pdAnimal, @Param("startRow") int startRow, @Param("endRow") int endRow);

    @Query(value = "SELECT * FROM ( SELECT p.*, ROW_NUMBER() OVER (ORDER BY pd_num) AS rn FROM product p WHERE pd_category = :pd_category ) WHERE rn BETWEEN :startRow AND :endRow", nativeQuery = true)
    List<PDto> findByPdCategory(@Param("pd_category") String pdCategory, @Param("startRow") int startRow, @Param("endRow") int endRow);
    
    
    
}




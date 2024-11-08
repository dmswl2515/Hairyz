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

    @Query("SELECT p FROM PDto p WHERE p.pdAnimal = :pd_animal")
    List<PDto> findByPdAnimal(@Param("pd_animal") String pd_animal);

    @Query("SELECT p FROM PDto p WHERE p.pdCategory = :pd_category")
    List<PDto> findByPdCategory(@Param("pd_category") String pd_category);

    
    @Query("SELECT p FROM PDto p WHERE p.pdAnimal = :pd_animal AND p.pdCategory = :pd_category")
    List<PDto> findByPdAnimalAndCategory(@Param("pd_animal") String pd_animal, @Param("pd_category") String pd_category);
    
    //페이지네이션 용도
    @Query(value = "SELECT COUNT(*) FROM product WHERE pd_animal = :pd_animal AND pd_category = :pd_category", nativeQuery = true)
    long countByPdAnimalAndCategory(@Param("pd_animal") String pd_animal, @Param("pd_category") String pd_category);
    
    @Query(value = "SELECT COUNT(*) FROM product WHERE pd_animal = :pd_animal", nativeQuery = true)
    long countByPdAnimal(@Param("pd_animal") String pd_animal);

    @Query(value = "SELECT COUNT(*) FROM product WHERE pd_category = :pd_category", nativeQuery = true)
    long countByPdCategory(@Param("pd_category") String pd_category);
    
    //키워드로 상품검색
    @Query("SELECT p FROM PDto p WHERE p.pdName LIKE %:sKeyword% AND p.pd_selling = 'Y'")
    List<PDto> findProductsByKeyword(@Param("sKeyword") String sKeyword);

    
    
}




package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.PDto;

@Repository
public interface PRepository extends JpaRepository<PDto, Integer>
{
	Page<PDto> findByPdNum(Integer pdNum, Pageable pageable);
	Page<PDto> findByPdNameContaining(String pdName, Pageable pageable);
}

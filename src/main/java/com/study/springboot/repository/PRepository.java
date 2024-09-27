package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.PDto;

@Repository
public interface PRepository extends JpaRepository<PDto, Integer>
{

	Page<PDto> findByPd_num(Integer pd_num, Pageable pageable);
	Page<PDto> findByPd_nameContaining(String pd_name, Pageable pageable);


}

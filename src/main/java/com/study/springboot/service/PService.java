package com.study.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dto.PDto;
import com.study.springboot.repository.PRepository;

@Service
public class PService 
{
	@Autowired
	private PRepository pRepository;
	
	//상품 등록
	public void saveProduct(PDto product) {
        pRepository.save(product);
    }
}

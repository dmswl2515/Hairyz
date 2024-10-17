package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
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
	
	// 모든 상품 리스트 
	public List<PDto> getAllProducts() {
        return pRepository.findAll(Sort.by(Sort.Direction.DESC, "pdRdate")); 
    }
	
	public List<PDto> getProductsByNumber(Integer productNum) {
	    return pRepository.findByPdNum(productNum);
	}

	public List<PDto> getProductsByName(String productName) {
	    return pRepository.findByPdNameContaining(productName);
	}
	
	//통합검색
	public List<PDto> getProductsByKeyword(String sKeyword) {
        return pRepository.findProductsByKeyword(sKeyword);
    }

	public PDto findByPdNum(Integer odNum)
	{
		List<PDto> productList = pRepository.findByPdNum(odNum);
	    return productList.isEmpty() ? null : productList.get(0); // 결과가 없으면 null 반환
	}
	
	
}

package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
        return pRepository.findAll(); 
    }
	
	public List<PDto> getProductsByNumber(Integer productNum) {
	    return pRepository.findByPdNum(productNum);
	}

	public List<PDto> getProductsByName(String productName) {
	    return pRepository.findByPdNameContaining(productName);
	}

	//제품 판매상태 변경
	public void updateSellingStatus(Integer pdNum, Character newStatus) {
        PDto product = pRepository.findById(pdNum)
            .orElseThrow(() -> new RuntimeException("제품을 찾을 수 없습니다"));

        // pd_selling 상태 변경
        product.setPd_selling(newStatus); // 새로운 상태로 업데이트
        pRepository.save(product); // 변경 사항 저장
    }
	
	
}

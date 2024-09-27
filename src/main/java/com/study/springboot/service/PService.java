package com.study.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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

	public Page<PDto> searchList(String sOption, String sKeyword, Pageable pageable)
	{
		if ("pd_num".equals(sOption)) {
			
			Integer pdNum;
	        try {
	            pdNum = Integer.valueOf(sKeyword);
	        } catch (NumberFormatException e) {
	            // 변환 실패 시 빈 페이지 반환
	            return Page.empty(pageable);
	        }
	        return pRepository.findByPd_num(pdNum, pageable);
	    } else if ("pd_name".equals(sOption)) {
	        return pRepository.findByPd_nameContaining(sKeyword, pageable);
	    } else {
	    	return pRepository.findAll(pageable);
	    }    
	}
}

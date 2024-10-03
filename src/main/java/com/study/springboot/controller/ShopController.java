package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dto.PDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;
import com.study.springboot.repository.PRepository;
import com.study.springboot.service.QnAService;

@Controller
public class ShopController {
	
	@Autowired
	private PRepository pRepository;
	
	@Autowired
	private QnAService qnaService;
    
    
    
    @RequestMapping("/s_main")    
    public String shoppingMainPage(@RequestParam(defaultValue = "1") int page,
                                   @RequestParam(required = false) String pd_animal,
                                   @RequestParam(required = false) String pd_category,
                                   Model model) {
        
        // 페이지당 항목 수
        int pageSize = 16; 
        
        // 총 상품 수를 데이터베이스에서 가져옵니다.
        long totalProducts = pRepository.count(); // 총 상품 수를 세는 메서드

        // 시작 행 번호 및 종료 행 번호를 계산합니다.
        int startRow = (page - 1) * pageSize; 
        int endRow = Math.min(startRow + pageSize, (int) totalProducts); 

        // 데이터베이스에서 현재 페이지에 해당하는 상품을 가져옵니다.
        List<PDto> products = pRepository.findPaginated(startRow, pageSize); // 시작 행 번호와 페이지 크기를 사용합니다.
        
        // 카테고리 또는 동물 필터링 적용
        if (pd_category != null && !pd_category.isEmpty()) {
            products = pRepository.findByPdCategory(pd_category, startRow, pageSize);
        } else if (pd_animal != null && !pd_animal.isEmpty()) {
            products = pRepository.findByPdAnimal(pd_animal, startRow, pageSize);
        }

        // 모델에 데이터 추가
        model.addAttribute("ProductItems", products); // 현재 페이지의 상품 리스트
        model.addAttribute("currentPage", page); // 현재 페이지 번호
        model.addAttribute("totalPages", (int) Math.ceil((double) totalProducts / pageSize)); // 전체 페이지 수
        model.addAttribute("startPage", Math.max(1, page - 2)); // 시작 페이지
        model.addAttribute("endPage", Math.min((int) Math.ceil((double) totalProducts / pageSize), page + 2)); // 끝 페이지

        return "s_main";                 
    }
    
    @RequestMapping("/p_details")    
    public String productDetail(@RequestParam(defaultValue = "1") int page,
								@RequestParam("pdNum") int pdNum, 
							 	@RequestParam(value = "qna_no", required = false, defaultValue = "0") int qna_no,
    							Model model) {
    	
    	// pdNum에 해당하는 상품 정보를 DB에서 가져옴
        List<PDto> product = pRepository.findByPdNum(pdNum);
        
        // 상품 정보가 있을 경우, 모델에 추가하여 JSP에서 사용할 수 있게 함
        if (!product.isEmpty()) {
            model.addAttribute("product", product.get(0));  // 첫 번째 상품 정보만 전달
        }
        
        List<QDto> qnaList = qnaService.getQnaByProductId(pdNum);
        model.addAttribute("qnaList", qnaList);
        
        List<QnaReplyDto> qnaRepList = qnaService.getQnaReplyByQnaNo(qna_no);
        if (qna_no > 0) {
            model.addAttribute("qnaRepList", qnaRepList);
            model.addAttribute("currentQnaRep", qnaRepList.isEmpty() ? null : qnaRepList.get(0)); // 첫 번째 답변만 추가
            System.out.println("qna_no: " + qna_no);
            System.out.println("qnaRepList: " + qnaRepList);
        } else {
            System.out.println("qna_no는 0입니다. Q&A 답변을 가져올 수 없습니다.");
        }
        
	        // 페이지네이션 설정
	        int pageSize = 1; // 페이지당 항목 수
	        int totalQnAs = qnaRepList.size(); // 전체 상품 수
	        int startRow = (page - 1) * pageSize; // 시작 인덱스
	        int endRow = Math.min(startRow + pageSize, totalQnAs);
	        
	        List<QnaReplyDto> paginatedQnAs = qnaRepList.subList(startRow, endRow);
	        
	        model.addAttribute("products", paginatedQnAs);
	        model.addAttribute("currentPage", page); // 현재 페이지 번호
	        model.addAttribute("totalPages", (int) Math.ceil((double) totalQnAs / pageSize)); // 전체 페이지 수
	        model.addAttribute("startPage", Math.max(1, page - 2)); // 시작 페이지
	        model.addAttribute("endPage", Math.min((int) Math.ceil((double) totalQnAs / pageSize), page + 2)); // 끝 페이지
        
            return "s_details";              
    }
    
    @RequestMapping("/s_purchase")    
    public String productPhrchase(Model model) {
    	
            return "s_purchase";              
    }
}


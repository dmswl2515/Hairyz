package com.study.springboot.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.study.springboot.dto.PDto;
import com.study.springboot.repository.PRepository;
import com.study.springboot.service.PService;
import com.study.springboot.service.QnAService;

import jakarta.servlet.ServletContext;

@Controller
public class PController {
	
	@Autowired
	private PRepository pRepository;
	
	@Autowired
	private PService pService;
	
	@Autowired
	private QnAService qnaService;
    
    @RequestMapping("/p_registration")    
    public String pRegisterForm() {
        return "p_registration";                 
    }
    
    
    private final String uploadDir;

    @Autowired
    public PController(ServletContext servletContext) {
        this.uploadDir = servletContext.getRealPath("/upload/");
    }
    
    
    @PostMapping("/p_registration")    
    public String handleInformation(@RequestParam("file") MultipartFile file, 
						    		@RequestParam("file2") MultipartFile file2,
						            @RequestParam("pdName") String pdName,
						            @RequestParam("pd_animal") String pdAnimal,
						            @RequestParam("pd_category") String pdCategory,
						            @RequestParam("pd_price") Integer pd_price,
						            @RequestParam("pd_amount") Integer pd_amount) throws IOException  {
        
    	// 파일 존재 여부 체크
    	if (file.isEmpty() || file2.isEmpty()) {
            throw new IllegalArgumentException("모든 파일을 선택해야 합니다.");
        }
    	
    	// 랜덤한 파일 번호 생성(중복 체크)
    	Integer pd_fnum;
        do {
            pd_fnum = new Random().nextInt(100000);
        } while (pRepository.existsById(pd_fnum));

        // 첫 번째 파일 정보 처리
        String originalFilename1 = file.getOriginalFilename();
        String changedFilename1 = System.currentTimeMillis() + "_" + originalFilename1; // 현재 시간 기반의 랜덤 파일 이름
        String filePath1 = uploadDir + changedFilename1;

        // 첫번 째 파일 저장
        Path path1 = Paths.get(filePath1);
        Files.createDirectories(path1.getParent());
        Files.write(path1, file.getBytes());
        
        // 두 번째 파일 정보 처리
        String originalFilename2 = file2.getOriginalFilename();
        String changedFilename2 = System.currentTimeMillis() + "_" + originalFilename2; // 현재 시간 기반의 랜덤 파일 이름
        String filePath2 = uploadDir + changedFilename2;

        // 두 번째 파일 저장
        Path path2 = Paths.get(filePath2);
        Files.createDirectories(path2.getParent());
        Files.write(path2, file2.getBytes());

        // PDto 객체 생성 및 저장
        PDto product = new PDto();
        product.setPdNum(pd_fnum);
        product.setPdName(pdName);
        product.setPdCategory(pdCategory);
        product.setPdAnimal(pdAnimal);
        product.setPd_price(pd_price);
        product.setPd_amount(pd_amount);
        product.setPd_fee(0); // 기본값 설정
        product.setPd_selling('Y'); // 기본값 설정
        product.setPdRdate(new Date());
        
        
        // 첫 번째 파일 정보 저장
        product.setPd_fnum(pd_fnum);
        product.setPd_ori_fname(originalFilename1);
        product.setPd_chng_fname(changedFilename1);
        product.setPd_fdate(new Date());
        product.setPd_fpath(filePath1);
        product.setPd_fsize(String.valueOf(file.getSize()));

        // 두 번째 파일 정보 저장
        product.setPd_ori_fname2(originalFilename2);
        product.setPd_chng_fname2(changedFilename2);
        product.setPd_fdate2(new Date());
        product.setPd_fpath2(filePath2);
        product.setPd_fsize2(String.valueOf(file2.getSize()));

        pRepository.save(product); // DB에 저장

        return "redirect:/p_manage"; // 업로드 후 리다이렉트                 
    }

    @GetMapping("/p_manage")
    public String getAllProducts(@RequestParam(defaultValue = "1") int page,
    							 @RequestParam(value = "condition", required = false) String condition,
        						 @RequestParam(value = "keyword", required = false) String keyword,
        						 Model model) {
    	
    	
    	
    	List<PDto> productList = new ArrayList<>();

        if ("productNumber".equals(condition) && keyword != null && !keyword.isEmpty()) {
            try {
                Integer productNum = Integer.parseInt(keyword);
                productList = pService.getProductsByNumber(productNum); // 상품 번호로 검색
            } catch (NumberFormatException e) {
                productList = pService.getAllProducts(); // 잘못된 입력일 경우 모든 상품 반환
            }
        } else if ("productName".equals(condition) && keyword != null && !keyword.isEmpty()) {
            productList = pService.getProductsByName(keyword); // 상품명으로 검색
//        } else if ("all".equals(condition)) {
//            productList = pService.getAllProducts();
        } else {
            productList = pService.getAllProducts(); // 기본적으로 모든 상품 반환
        }
        
        // 페이지네이션 설정
        int pageSize = 5; // 페이지당 항목 수
        int totalProducts = productList.size(); // 전체 상품 수
        int startRow = (page - 1) * pageSize; // 시작 인덱스
        int endRow = Math.min(startRow + pageSize, totalProducts);
        
        List<PDto> paginatedProducts = productList.subList(startRow, endRow);
        
        model.addAttribute("products", paginatedProducts);
        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page); // 현재 페이지 번호
        model.addAttribute("totalPages", (int) Math.ceil((double) totalProducts / pageSize)); // 전체 페이지 수
        model.addAttribute("startPage", Math.max(1, page - 2)); // 시작 페이지
        model.addAttribute("endPage", Math.min((int) Math.ceil((double) totalProducts / pageSize), page + 2)); // 끝 페이지

        return "p_manage"; // JSP 이름
    }
    
    @PostMapping("/updateSellingStatus")
    @ResponseBody
    public Map<String, Object> updateSellingStatus(@RequestParam("pdNum") Integer pdNum, 
	            					  			   @RequestParam("sellStatus") char sellStatus) {
    	
    	System.out.println(sellStatus);
    	Map<String, Object> response = new HashMap<>();
    	
    	try
		{
    		List<PDto> products = pRepository.findByPdNum(pdNum);
    		if (products.isEmpty()) {
    			throw new RuntimeException("제품을 찾을 수 없습니다: pdNum=" + pdNum);
    		}
    		
    		// 제품 상태 업데이트
    		PDto product = products.get(0); // 첫 번째 제품 가져오기
    		product.setPd_selling(sellStatus);
    		pRepository.save(product);
    		
    		response.put("status", "success");
    		response.put("message", "제품의 판매상태가 업데이트되었습니다.");
		} catch (Exception e)
		{
			response.put("status", "error");
			response.put("message", e.getMessage());
		}
       
		return response;
	}
    
 
    @RequestMapping("/p_modify")    
    public String pModifyForm(@RequestParam("pdNum") Integer pdNum, Model model) {
        
        List<PDto> products = pRepository.findByPdNum(pdNum);
        
        if (!products.isEmpty()) {
            model.addAttribute("product", products.get(0)); // 첫 번째 상품을 모델에 추가
        } 
         return "p_modify";
    }
    
    
    
    @PostMapping("/p_update")
    public String updateProduct(@RequestParam("pdNum") Integer pdNum,
					            @RequestParam("file") MultipartFile file,
					            @RequestParam("file2") MultipartFile file2,
					            @RequestParam("pdName") String pdName,
					            @RequestParam("pd_animal") String pdAnimal,
					            @RequestParam("pd_category") String pdCategory,
					            @RequestParam("pd_price") Integer pdPrice,
					            @RequestParam("pd_amount") Integer pdAmount,
					            RedirectAttributes redirectAttributes) throws IOException {
    	
    	// 기존 상품을 데이터베이스에서 찾기
    	List<PDto> products = pRepository.findByPdNum(pdNum);
    	
    	if (!products.isEmpty()) {
            PDto product = products.get(0); // 첫 번째 제품 정보 가져오기

            // 기존 파일 이름 저장
            String oldFileName1 = product.getPd_chng_fname(); // 기존 파일 이름
            String oldFileName2 = product.getPd_chng_fname2(); // 기존 파일 이름

            // 파일이 새로 업로드 되면 저장
            if (!file.isEmpty()) {
                // 새로운 파일 정보 처리
                String originalFilename1 = file.getOriginalFilename();
                String changedFilename1 = System.currentTimeMillis() + "_" + originalFilename1; // 현재 시간 기반의 랜덤 파일 이름
                String filePath1 = uploadDir + changedFilename1;

                // 파일 저장
                Path path1 = Paths.get(filePath1);
                Files.createDirectories(path1.getParent());
                Files.write(path1, file.getBytes());

                product.setPd_chng_fname(changedFilename1); // 새 파일 이름 설정
	    	} else {
	            // 두 번째 파일이 선택되지 않은 경우 기존 파일 이름 유지
	            product.setPd_chng_fname2(oldFileName1);
	        }

            if (!file2.isEmpty()) {
                // 두 번째 파일 정보 처리
                String originalFilename2 = file2.getOriginalFilename();
                String changedFilename2 = System.currentTimeMillis() + "_" + originalFilename2; // 현재 시간 기반의 랜덤 파일 이름
                String filePath2 = uploadDir + changedFilename2;

                // 파일 저장
                Path path2 = Paths.get(filePath2);
                Files.createDirectories(path2.getParent());
                Files.write(path2, file2.getBytes());

                product.setPd_chng_fname2(changedFilename2); // 새 파일 이름 설정
            } else {
                // 두 번째 파일이 선택되지 않은 경우 기존 파일 이름 유지
                product.setPd_chng_fname2(oldFileName2);
            }
            

            // 상품 정보 업데이트
            product.setPdName(pdName);
            product.setPdAnimal(pdAnimal);
            product.setPdCategory(pdCategory);
            product.setPd_price(pdPrice);
            product.setPd_amount(pdAmount);
            product.setPd_fee(product.getPd_fee()); // 기존 pd_fee를 설정
            product.setPd_selling(product.getPd_selling()); // 기존 pd_selling을 설정
            product.setPdRdate(product.getPdRdate()); // 기존 pd_rdate를 설정
            

            // 제품 정보 저장
            pRepository.save(product);
            
        }
    	return "redirect:/p_modify?pdNum=" + pdNum;
    }
    
}


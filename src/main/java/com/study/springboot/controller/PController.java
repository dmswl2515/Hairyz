package com.study.springboot.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.PDto;
import com.study.springboot.repository.PRepository;
import com.study.springboot.service.PService;

import jakarta.servlet.ServletContext;

@Controller
public class PController {
	
	@Autowired
	private PRepository pRepository;
	
	@Autowired
	private PService pService;
    
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
						            @RequestParam String pdName, 
						            @RequestParam String pd_category, 
						            @RequestParam String pd_animal, 
						            @RequestParam Integer pd_price, 
						            @RequestParam Integer pd_amount) throws IOException  {
        
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
        String filePath1 = "upload/" + changedFilename1;

        // 첫번 째 파일 저장
        Path path1 = Paths.get(filePath1);
        Files.createDirectories(path1.getParent());
        Files.write(path1, file.getBytes());
        
        // 두 번째 파일 정보 처리
        String originalFilename2 = file2.getOriginalFilename();
        String changedFilename2 = System.currentTimeMillis() + "_" + originalFilename2; // 현재 시간 기반의 랜덤 파일 이름
        String filePath2 = "upload/" + changedFilename2;

        // 두 번째 파일 저장
        Path path2 = Paths.get(filePath2);
        Files.createDirectories(path2.getParent());
        Files.write(path2, file2.getBytes());

        // PDto 객체 생성 및 저장
        PDto product = new PDto();
        product.setPdNum(pd_fnum);
        product.setPdName(pdName);
        product.setPd_category(pd_category);
        product.setPd_animal(pd_animal);
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
    public String getAllProducts(@RequestParam(value = "page", defaultValue = "1") int currentPage,
    							 @RequestParam(value = "size", defaultValue = "5") int size, // 한 페이지당 항목 수
    							 @RequestParam(value = "condition", required = false) String condition,
        						 @RequestParam(value = "keyword", required = false) String keyword,
        						 Model model) {
    	
    	
    	
    	List<PDto> productList;

        if ("productNumber".equals(condition) && keyword != null && !keyword.isEmpty()) {
            try {
                Integer productNum = Integer.parseInt(keyword);
                productList = pService.getProductsByNumber(productNum); // 상품 번호로 검색
            } catch (NumberFormatException e) {
                productList = pService.getAllProducts(); // 잘못된 입력일 경우 모든 상품 반환
            }
        } else if ("productName".equals(condition) && keyword != null && !keyword.isEmpty()) {
            productList = pService.getProductsByName(keyword); // 상품명으로 검색
        } else if ("all".equals(condition)) {
            productList = pService.getAllProducts();
        } else {
            productList = pService.getAllProducts(); // 기본적으로 모든 상품 반환
        }
        
        // 페이지네이션 설정
        int totalProducts = productList.size(); // 전체 상품 수
        int totalPages = (int) Math.ceil((double) totalProducts / size); // 총 페이지 수
        int startPage = Math.max(1, currentPage - 2); // 시작 페이지
        int endPage = Math.min(totalPages, currentPage + 2); // 끝 페이지

        model.addAttribute("products", productList);
        model.addAttribute("condition", condition); 
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "p_manage"; // JSP 이름
    }
    
 
    @RequestMapping("/p_modify")    
    public String pModifyForm(@RequestParam("pdNum") Integer pdNum, Model model) {
        List<PDto> products = pRepository.findByPdNum(pdNum);
        
        if (!products.isEmpty()) {
            model.addAttribute("product", products.get(0)); // 첫 번째 상품을 모델에 추가
            return "p_modify"; // 수정 페이지 이름
        } else {
            return "redirect:/error"; 
        }               
    }
    
    @PostMapping("/p_update")
    public String updateProduct(@ModelAttribute PDto product, 
    							@RequestParam("file") MultipartFile file,
					    		@RequestParam("file2") MultipartFile file2,
    							Model model) {
    	if (product.getPdNum() != null) {
            // 상품 정보를 업데이트하는 로직 추가
            pRepository.save(product); // pdNum이 있는 경우 업데이트
        } else {
            // 에러 처리: pdNum이 null이면 수정할 수 없음
            model.addAttribute("error", "상품 번호가 누락되었습니다.");
            return "p_update"; // 에러가 발생한 경우 수정 페이지로 돌아감
        }
        return "redirect:/p_manage";
    }
    
    
    @RequestMapping("/s_main")    
    public String shoppingMainPage(Model model) {
    	 List<PDto> productItems = pService.getAllProducts(); // 상품 목록 가져오기
         model.addAttribute("ProductItems", productItems);
        return "s_main";                 
    }
    
    @RequestMapping("/p_details")    
    public String productDetail(@RequestParam("pdNum") int pdNum, Model model) {
    	
    	// pdNum에 해당하는 상품 정보를 DB에서 가져옴
        List<PDto> product = pRepository.findByPdNum(pdNum);
        
        // 상품 정보가 있을 경우, 모델에 추가하여 JSP에서 사용할 수 있게 함
        if (!product.isEmpty()) {
            model.addAttribute("product", product.get(0));  // 첫 번째 상품 정보만 전달
        }
            return "p_details";  // p_detail.jsp로 이동                
    }
}


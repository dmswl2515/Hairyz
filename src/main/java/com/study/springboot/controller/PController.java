package com.study.springboot.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.PDto;
import com.study.springboot.repository.PRepository;

@Controller
public class PController {
	
	@Autowired
	private PRepository pRepository;
    
    @RequestMapping("/p_registration")    
    public String pRegisterForm() {
        return "p_registration";                 
    }
    
    private final String uploadDir = "uploads/"; //파일 저장 경로
    
    @PostMapping("/p_registration")    
    public String handleInformation(@RequestParam("file") MultipartFile file, 
						    		@RequestParam("file2") MultipartFile file2,
						            @RequestParam String pd_name, 
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
            pd_fnum = new Random().nextInt(10000);
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
        product.setPd_num(pd_fnum);
        product.setPd_name(pd_name);
        product.setPd_category(pd_category);
        product.setPd_animal(pd_animal);
        product.setPd_price(pd_price);
        product.setPd_amount(pd_amount);
        product.setPd_fee(0); // 기본값 설정
        product.setPd_selling('Y'); // 기본값 설정
        product.setPd_rdate(new Date());
        
        
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

        return "p_manage"; // 업로드 후 리다이렉트                 
    }

 
    @RequestMapping("/p_modify")    
    public String pModifyForm() {
        return "p_modify";                 
    }
    
}


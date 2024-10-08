package com.study.springboot.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.BoardDto;
import com.study.springboot.service.BoardService;

@Controller
public class BdController {

    @Autowired
    private BoardService boardService;

    
    @RequestMapping("/write.do")
    public String join(Model model) {
        return "write"; // join.jsp를 반환
    }

    @PostMapping("/writeOk.do")
    public String writeOk(BoardDto boardDto, MultipartFile bd_file, HttpServletRequest request) {
        // 파일 업로드 경로 설정 (서버 내 저장 경로)
        String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // 폴더가 없으면 생성
        }

        // 파일 첨부가 있을 경우 처리
        if (!bd_file.isEmpty()) {
            try {
                // 유저가 첨부한 파일의 원본 이름
                String originalFileName = bd_file.getOriginalFilename();
                boardDto.setBd_orgname(originalFileName);

                // 시스템에서 관리할 중복되지 않는 파일 이름 생성
                String uuid = UUID.randomUUID().toString();
                String systemFileName = uuid + "_" + originalFileName;
                boardDto.setBd_modname(systemFileName);

                // 파일을 지정한 경로에 저장
                File file = new File(uploadPath, systemFileName);
                bd_file.transferTo(file);

                // 파일 경로 저장
                boardDto.setBd_imgpath("/upload/" + systemFileName);

            } catch (IOException e) {
                e.printStackTrace();
                return "redirect:/write?error";  // 파일 업로드 실패 시
            }
        }

        // 게시글 데이터베이스에 저장
        boardService.writePost(boardDto);

        return "redirect:/list";  // 게시글 목록 페이지로 리다이렉트
    }

    @PostMapping("/uploadFile")
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        // 파일 업로드 경로 설정
        String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // 폴더가 없으면 생성
        }

        // 파일 처리
        if (!file.isEmpty()) {
            try {
                // 유저가 첨부한 파일의 원본 이름
                String originalFileName = file.getOriginalFilename();

                // 시스템에서 관리할 중복되지 않는 파일 이름 생성
                String uuid = UUID.randomUUID().toString();
                String systemFileName = uuid + "_" + originalFileName;

                // 파일을 지정한 경로에 저장
                File saveFile = new File(uploadPath, systemFileName);
                file.transferTo(saveFile);

                // 파일 경로와 파일 링크를 응답 데이터로 반환
                response.put("success", true);
                response.put("fileLink", "/upload/" + systemFileName);
                response.put("fileName", originalFileName);  // 원본 파일 이름
                response.put("systemFileName", systemFileName);  // 서버에 저장된 파일 이름
                response.put("filePath", "/upload/" + systemFileName);  // 파일 경로

            } catch (IOException e) {
                e.printStackTrace();
                response.put("success", false);
                response.put("message", "파일 저장 중 오류가 발생했습니다.");
            }
        } else {
            response.put("success", false);
            response.put("message", "첨부된 파일이 없습니다.");
        }

        return response;  // JSON 형식으로 응답
        
    }


}

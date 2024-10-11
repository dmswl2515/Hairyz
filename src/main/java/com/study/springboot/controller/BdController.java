package com.study.springboot.controller;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.ReplyDto;
import com.study.springboot.service.BoardService;
import com.study.springboot.service.MemberService;
import com.study.springboot.service.ReplyService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BdController {

    @Autowired
    private BoardService boardService;
    
    @Autowired
    private ReplyService replyService;
    
    @Autowired
    private MemberService memberService;
    
    @Autowired
    private ServletContext servletContext;

    @RequestMapping("/write.do")
    public String write(Model model) {
        return "write"; // write.jsp를 반환
    }

    @PostMapping("/uploadFile")
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws ServletException, IOException {
        Map<String, Object> response = new HashMap<>();
        
        String uploadPath = ResourceUtils.getFile(servletContext.getRealPath("/upload/")).toPath().toString();
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        if (!file.isEmpty()) {
            try {
                String originalFileName = file.getOriginalFilename();
                String systemFileName = generateHash(originalFileName + System.currentTimeMillis()) + "_" + originalFileName;

                File saveFile = new File(uploadPath, systemFileName);
                file.transferTo(saveFile);

                response.put("success", true);
                response.put("fileLink", "/upload/" + systemFileName); // 파일 경로
                response.put("originalFileName", originalFileName); // 원본 파일명
                response.put("systemFileName", systemFileName); // 해시값을 적용한 파일명
            } catch (IOException e) {
                e.printStackTrace();
                response.put("success", false);
                response.put("message", "파일 저장 중 오류가 발생했습니다.");
            }
        } else {
            response.put("success", false);
            response.put("message", "첨부된 파일이 없습니다.");
        }

        return response;
    }
    
    // 해시값 생성 메서드
    private String generateHash(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(input.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString().substring(0, 8); // 첫 8자리만 사용
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    @PostMapping("/writeOk.do")
    @ResponseBody
    public Map<String, Object> writeOk(BoardDto boardDto, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        // 세션에서 userId와 userNickname 가져오기
        HttpSession session = request.getSession();
        String userNickname = (String) session.getAttribute("userNickname");
        String userId = (String) session.getAttribute("userId");

        // 작성자 정보가 세션에서 정상적으로 가져왔는지 확인
        if (userNickname != null && !userNickname.isEmpty()) {
            boardDto.setMb_id(userId);  // 작성자 ID 설정
            boardDto.setBd_writer(userNickname);  // 작성자 설정
        } else {
            response.put("result", "fail");
            response.put("message", "작성자 정보가 없습니다. 로그인 여부를 확인해 주세요.");
            return response;
        }

        // 파일 정보를 받아옴
        String success = request.getParameter("success");
        String imgPathFromUpload = request.getParameter("fileLink"); // 파일 경로
        String originalFileName = request.getParameter("originalFileName"); // 원본 파일명
        String systemFileName = request.getParameter("systemFileName"); // 해시값으로 저장된 파일명

        // 파일이 성공적으로 업로드된 경우에만 파일 정보를 DTO에 설정
        if ("true".equals(success)) {
            // imgPathFromUpload에서 파일명을 제외한 경로만 저장
            if (imgPathFromUpload != null) {
                int lastSlashIndex = imgPathFromUpload.lastIndexOf('/');
                if (lastSlashIndex != -1) {
                    imgPathFromUpload = imgPathFromUpload.substring(0, lastSlashIndex); // 경로만 남김
                }
            }

            // DTO에 파일 정보 설정
            boardDto.setBd_imgpath(imgPathFromUpload); // 파일 경로 (파일명 제외)
            boardDto.setBd_orgname(originalFileName); // 원본 파일명
            boardDto.setBd_modname(systemFileName); // 해시값으로 된 파일명
        } else {
            // 파일이 업로드되지 않았을 경우, 필드를 null로 설정
            boardDto.setBd_imgpath(null);
            boardDto.setBd_orgname(null);
            boardDto.setBd_modname(null);
        }

        // 게시글 작성 서비스 호출
        try {
            boardService.writePost(boardDto);
            response.put("result", "success");
            response.put("redirectUrl", "/list.do"); // 성공 시 목록 페이지로 이동하도록 URL 반환
        } catch (Exception e) {
            e.printStackTrace();
            response.put("result", "fail");
            response.put("message", "게시글 작성 중 오류가 발생했습니다.");
        }

        return response;
    }
    
    // 게시글 상세 페이지
    @GetMapping("/post_view.do/{bd_no}")
    public String viewPost(@PathVariable("bd_no") int bdNo, Model model, HttpServletRequest request) {
    	// 게시글 정보 조회
        BoardDto board = boardService.getPostView(bdNo);
        // 작성자의 프로필 정보 조회
        MemberDto profile = memberService.getMemberByMemberId(board.getMb_id());
        // 세션에서 사용자 ID 가져오기
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        // 댓글 리스트 조회
        List<ReplyDto> reply = replyService.getReplyByBoardId(bdNo);
        model.addAttribute("board", board);
        model.addAttribute("profile", profile); 
        model.addAttribute("reply", reply);
        model.addAttribute("userId", userId);
        model.addAttribute("likeCount", boardService.getLikeCount(bdNo)); // 좋아요 수
        return "post_view";
    }
    
    // 좋아요 토글 처리
    @PostMapping("/upLike")
    @ResponseBody
    public Map<String, Object> toggleLike(@RequestParam("boardId") int boardId, HttpSession session) {
        // 세션에서 사용자 ID 가져오기 (로그인 필수)
        String userId = (String) session.getAttribute("userId");

        // 반환할 결과 맵
        Map<String, Object> result = new HashMap<>();

        if (userId == null) {
            // 로그인하지 않은 경우 처리
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
        } else {
            // 좋아요 상태를 토글하고 현재 좋아요 수 리턴
            int updatedLikeCount = boardService.toggleLike(userId, boardId);
            result.put("success", true);
            result.put("likes", updatedLikeCount);
        }

        return result;
    }
    
    // 좋아요 상태 확인
    @GetMapping("/getLikeStatus")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getLikeStatus(@RequestParam("boardId")int boardId, HttpSession session) {
        // 세션에서 사용자 ID 가져오기
        String userId = (String) session.getAttribute("userId");
        boolean liked = boardService.checkUserLike(userId, boardId); // 사용자가 좋아요를 누른 상태인지 확인
        
        // 응답 맵 생성
        Map<String, Object> response = new HashMap<>();
        response.put("liked", liked);
        
        return ResponseEntity.ok(response);
    }


    @RequestMapping("/list.do")
    public String list(Model model) {
    	
        return "list"; // list.jsp를 반환
    }


}

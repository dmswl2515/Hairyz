package com.study.springboot.controller;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    
    @Value("${KAKAO-KEY}")
    private String KAKAO_KEY;
    
    private static final Logger logger = LoggerFactory.getLogger(BdController.class); // Logger 생성

    @RequestMapping("/write.do")
    public String write(Model model) {
    	
    	model.addAttribute("kakaoKey", KAKAO_KEY);
    	
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
        	int bd_no = boardService.writePost(boardDto);
            response.put("result", "success");
            response.put("redirectUrl", "/post_view.do/" + bd_no); // 성공 시 해당 글로 리디렉션
        } catch (Exception e) {
            e.printStackTrace();
            response.put("result", "fail");
            response.put("message", "게시글 작성 중 오류가 발생했습니다.");
        }

        return response;
    }
    
    // 게시글 상세 페이지
    @GetMapping("/post_view.do/{bd_no}")
    public String viewPost(@PathVariable("bd_no") int bd_no,
			    	       @RequestParam(value = "page", defaultValue = "1") int currentPage,
			    	       @RequestParam(value = "category", required = false) String category,
			    	       @RequestParam(value = "condition", required = false) String searchCondition,
			    	       @RequestParam(value = "keyword", required = false) String searchKeyword,
			    	       Model model,
			    	       HttpServletRequest request) {
    	// 세션에서 사용자 ID 가져오기
    	HttpSession session = request.getSession();
    	String userId = (String) session.getAttribute("userId");
    	
    	// 게시글 정보 조회
        BoardDto board = boardService.getPostView(bd_no, userId);
        
        // 작성자의 프로필 정보 조회
        MemberDto profile = memberService.getMemberByMemberId(board.getMb_id());
        
        // 댓글 리스트 조회 및 댓글 작성자의 프로필 정보를 조회하여 모델에 추가
        List<ReplyDto> replyList = replyService.getRepliesByBdNo(bd_no);
        List<MemberDto> replyProfiles = new ArrayList<>();
        for (ReplyDto reply : replyList) {
            // 댓글 작성자의 프로필 정보 조회
            MemberDto replyProfile = memberService.getMemberByMemberId(reply.getMb_id());
            replyProfiles.add(replyProfile);
        }
        
        // 모델에 정보 추가
        model.addAttribute("kakaoKey", KAKAO_KEY);
        model.addAttribute("board", board);
        model.addAttribute("profile", profile); 
        model.addAttribute("replyList", replyList);
        model.addAttribute("replyProfiles", replyProfiles); // 댓글 작성자 프로필 리스트
        model.addAttribute("userId", userId);
        model.addAttribute("likeCount", boardService.getLikeCount(bd_no)); // 좋아요 수
        model.addAttribute("replyCount", replyList.size()); // 댓글 수
        // 게시글 ID를 모델에 추가 (AJAX에서 사용할 수 있도록)
        model.addAttribute("bd_no", bd_no);
        // 목록페이지에서 페이지, 카테고리, 검색조건 받아오기
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("category", category);
        model.addAttribute("searchCondition", searchCondition);
        model.addAttribute("searchKeyword", searchKeyword);
        
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
    
    // 댓글 입력
    @PostMapping("/addReply")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addReply(@RequestParam("bd_no") int bd_no, 
    													@RequestParam("rp_content") String rp_content, 
    													HttpServletRequest request) 
    {
        Map<String, Object> response = new HashMap<>();

        // 세션에서 사용자 ID와 닉네임 가져오기
        HttpSession session = request.getSession();
        String writerId = (String) session.getAttribute("userId");
        String writerNickname = (String) session.getAttribute("userNickname");
        
        // 사용자 ID 또는 닉네임이 없는 경우 처리
        if (writerId == null || writerNickname == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.ok(response);
        }
        
        // ReplyDto 객체 생성
        ReplyDto replyDto = new ReplyDto();
        replyDto.setBd_no(bd_no);
        replyDto.setMb_id(writerId);
        replyDto.setRp_writer(writerNickname);
        replyDto.setRp_content(rp_content);
        
        // 댓글 추가 로직 (데이터베이스에 저장)
        boolean success = replyService.addReply(replyDto);

        if (success) {
            // 댓글 추가 후 응답 데이터 생성
            response.put("success", true);
            response.put("writerId", writerId);
            response.put("writer", writerNickname);
            response.put("date", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
            response.put("content", rp_content);
            
            // 댓글 작성자의 프로필 이미지 경로 가져오기
            MemberDto writerProfile = memberService.getMemberByMemberId(writerId); // 작성자의 MemberDto 가져오기
            String writerImgPath = (writerProfile != null) ? writerProfile.getMb_imgpath() : null; // 프로필 이미지 경로
            
            // 기본 프로필 이미지 경로
            String defaultProfileImgPath = request.getContextPath() + "/images/logo.png"; // 기본 프로필 이미지 경로 설정
            
            // 웹에서 접근할 수 있는 경로로 변환
            if (writerImgPath != null) {
                // mb_imgpath에서 "/upload/"를 포함한 경로로 변환
                writerImgPath = request.getContextPath() + "/upload/" + writerImgPath.substring(writerImgPath.lastIndexOf("\\") + 1);
            }

            // 응답에 프로필 이미지 경로 추가
            response.put("writerImg", (writerImgPath != null) ? writerImgPath : defaultProfileImgPath); // 프로필 이미지 설정
        } else {
            response.put("success", false);
            response.put("message", "댓글 추가에 실패했습니다. 다시 시도하세요.");
        }

        return ResponseEntity.ok(response);
    }

    // 게시글 목록 출력
    @GetMapping("/list.do")
    public String getBoardList(
        @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(value = "category", required = false) String category,
        Model model) {

        int pageSize = 3; // 한 페이지에 보여줄 게시글 수
        int totalCount;

        if ("all".equals(category)) {
            category = null;
        }
        
        totalCount = boardService.getBoardCount(category, null, null); // 총 게시글 수
        int totalPages = totalCount > 0 ? (int) Math.ceil((double) totalCount / pageSize) : 0; // 전체 페이지 수

        List<BoardDto> boardList = boardService.getBoardList(page, pageSize, category, null, null);
        for (BoardDto board : boardList) {
            board.extractImageUrl(); // 각 게시글에서 이미지 URL 추출
        }

        model.addAttribute("kakaoKey", KAKAO_KEY);
        model.addAttribute("boardList", boardList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("category", category);
//        System.out.println("category: " + category);

        return "list"; // list.jsp 반환
    }
    
    // 게시글 검색
    @GetMapping("/boardSearch")
    public String searchBoard(@RequestParam(value = "page", defaultValue = "1") int page,
					          @RequestParam(value = "category", required = false) String category,
					          @RequestParam(value = "condition", required = false) String condition,
					          @RequestParam(value = "keyword", required = false) String keyword,
					          Model model) {

        int pageSize = 3; // 한 페이지에 보여줄 게시글 수
        int totalCount;

        // 검색 조건이 있을 때 isSearch를 true로 설정
        boolean isSearch = (condition != null && !condition.isEmpty() && keyword != null && !keyword.isEmpty());
        
        // 만약 검색 중이고, 페이지가 명시되지 않았다면 page를 1로 설정 (첫 검색일 때만 1페이지로 고정)
        if (isSearch && page == 1) {
            page = 1;
        } else if (isSearch && page > 1) {
            // 검색 결과 내에서 페이지 변경 시 해당 페이지를 유지
            // 여기는 page 값을 그대로 유지함
        }

        // 검색 조건 및 키워드 처리
        if ("all".equals(category)) {
            category = null;
        }

        totalCount = boardService.getBoardCount(category, condition, keyword); // 검색된 게시글 수
        int totalPages = totalCount > 0 ? (int) Math.ceil((double) totalCount / pageSize) : 0; // 전체 페이지 수

        List<BoardDto> boardList = boardService.getBoardList(page, pageSize, category, condition, keyword);

        model.addAttribute("boardList", boardList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("category", category);
        model.addAttribute("searchCondition", condition);
        model.addAttribute("searchKeyword", keyword);
        model.addAttribute("isSearch", isSearch); 

        return "list"; // list.jsp 반환
    }
    
    @GetMapping("/delete.do")
    public String deletePost(@RequestParam("bd_no") int bd_no, RedirectAttributes redirectAttributes) {
    	// 게시글 상태를 'N'으로 변경
        boolean isDeleted = boardService.deletePost(bd_no);

        if (isDeleted) {
            redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "게시글 삭제에 실패했습니다.");
        }

        return "redirect:/list.do"; // 삭제 후 게시글 목록으로 리다이렉트
    }
    
    @GetMapping("/deleteReply.do")
    public String deleteReply(@RequestParam("rp_no") int rp_no, 
                              @RequestParam("bd_no") int bd_no, 
                              RedirectAttributes redirectAttributes) {
        // 댓글 삭제 로직 처리 (댓글을 실제로 삭제하거나 상태를 변경)
        boolean isDeleted = replyService.deleteReply(rp_no);

        if (isDeleted) {
            redirectAttributes.addFlashAttribute("message", "댓글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "댓글 삭제에 실패했습니다.");
        }

        // 삭제 후 댓글이 있던 게시글로 리다이렉트
        return "redirect:/post_view.do/" + bd_no;
    }

    @GetMapping("/post_edit.do/{bd_no}")
    public String editPost(@PathVariable("bd_no") int bd_no, Model model) {
        BoardDto board = boardService.getPostById(bd_no);
        model.addAttribute("kakaoKey", KAKAO_KEY);
        model.addAttribute("board", board);
        return "post_edit";  // 수정 페이지 JSP
    }
    
    // 게시글 수정 처리
    @PostMapping("/editOk.do")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editPost(BoardDto boardDto, MultipartHttpServletRequest multiRequest, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 기존 게시글 정보 가져오기
            BoardDto existingPost = boardService.getPostById(boardDto.getBd_no());

            // 세션에서 userId 가져오기
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("userId");

            // 작성자 아이디와 세션 아이디 비교
            if (!existingPost.getMb_id().equals(userId)) {
                response.put("result", "fail");
                response.put("message", "작성자만 게시글을 수정할 수 있습니다.");
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
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
                // 파일이 업로드되지 않았을 경우, 기존 파일 정보를 유지
                boardDto.setBd_imgpath(existingPost.getBd_imgpath());
                boardDto.setBd_orgname(existingPost.getBd_orgname());
                boardDto.setBd_modname(existingPost.getBd_modname());
            }

            // 게시글 수정 처리
            boardService.updatePost(boardDto);

            response.put("result", "success");
            response.put("redirectUrl", "/post_view.do/" + boardDto.getBd_no());  // 수정된 게시글로 이동
        } catch (Exception e) {
            response.put("result", "fail");
            response.put("message", "게시글 수정 중 오류가 발생했습니다.");
            e.printStackTrace();
        }

        return ResponseEntity.ok(response);
    }

}

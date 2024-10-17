package com.study.springboot.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.study.springboot.dao.ICartDao;
import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dto.CartDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrdersDto;
import com.study.springboot.dto.PDto;
import com.study.springboot.dto.ProductOrderDto;
import com.study.springboot.dto.ProductReviewDto;
import com.study.springboot.dto.QDto;
import com.study.springboot.dto.QnaReplyDto;
import com.study.springboot.dto.ReviewReplyDto;
import com.study.springboot.repository.PRepository;
import com.study.springboot.service.CartService;
import com.study.springboot.service.MemberService;
import com.study.springboot.service.OrdersService;
import com.study.springboot.service.PService;
import com.study.springboot.service.ProductReviewService;
import com.study.springboot.service.QnAService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ShopController {
	
	@Autowired
    private IMemberDao memberDao;
	
	@Autowired
    private ICartDao cartDao;
	
	@Autowired
	private PRepository pRepository;
	
	@Autowired
	private QnAService qnaService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private OrdersService oService;
	
	@Autowired
    private ProductReviewService PRService;
	
	@Autowired
    private PService pService;
	
	
	
	
    
    
    
	@RequestMapping("/s_main")    
	public String shoppingMainPage(@RequestParam(defaultValue = "1") int page,
	                               @RequestParam(required = false) String pd_animal,
	                               @RequestParam(required = false) String pd_category,
	                               Model model) {
	    
	    // 페이지당 항목 수 설정
	    int pageSize = 16; 
	    long totalProducts = 0; // 전체 상품 수를 위한 변수
	    List<PDto> products = new ArrayList<>(); // 상품 리스트 초기화

	    // 동물 및 카테고리 필터링 적용
	    if (pd_category != null && !pd_category.isEmpty() && pd_animal != null && !pd_animal.isEmpty()) {
	        products = pRepository.findByPdAnimalAndCategory(pd_animal, pd_category);
	    } else if (pd_animal != null && !pd_animal.isEmpty()) {
	        products = pRepository.findByPdAnimal(pd_animal);
	    } else if (pd_category != null && !pd_category.isEmpty()) {
	        products = pRepository.findByPdCategory(pd_category);
	    } else {
	        products = pRepository.findAll(); // 모든 상품 조회
	    }
	    
	    // 전체 상품 수를 구합니다.
	    totalProducts = products.size();

	    // 페이지네이션 설정
	    int startRow = (page - 1) * pageSize; // 시작 인덱스
	    int endRow = (int) Math.min(startRow + pageSize, totalProducts); // 끝 인덱스
	    List<PDto> paginatedProducts = products.subList(startRow, endRow); // 페이지네이션된 상품 리스트

	    // 페이지네이션 설정
	    model.addAttribute("ProductItems", paginatedProducts); // 현재 페이지의 상품 리스트
	    model.addAttribute("currentPage", page); // 현재 페이지 번호
	    model.addAttribute("totalPages", (int) Math.ceil((double) totalProducts / pageSize)); // 전체 페이지 수
	    model.addAttribute("startPage", Math.max(1, page - 2)); // 시작 페이지
	    model.addAttribute("endPage", Math.min((int) Math.ceil((double) totalProducts / pageSize), page + 2)); // 끝 페이지

	    return "s_main";                 
	}
    
    @RequestMapping("/p_details")    
    public String productDetail(@RequestParam(defaultValue = "1") int qnaPage, 
    							@RequestParam(defaultValue = "1") int reviewPage,
								@RequestParam("pdNum") int pdNum,
								@RequestParam(value = "qna_no", required = false, defaultValue = "0") int qna_no,
								HttpSession session,
								Model model) {
    	
    	
    	// pdNum에 해당하는 상품 정보를 DB에서 가져옴
        List<PDto> product = pRepository.findByPdNum(pdNum);
        
        // 상품 정보가 있을 경우, 모델에 추가하여 JSP에서 사용할 수 있게 함
        if (!product.isEmpty()) {
            model.addAttribute("product", product.get(0));  // 첫 번째 상품 정보만 전달
            
        }
        
        //회원정보 가져오기
	    String memberId = (String) session.getAttribute("userId");
	    
        if (memberId != null) {
        	MemberDto memberList = mService.getMemberByMemberId(memberId);
        	model.addAttribute("memberList", memberList);
        	
        	System.out.println("memberList :" + memberList);
        } else {
        	System.out.println("Member ID is null");
        }
        
        //Q&A 페이징 처리
        List<QDto> qnaList = qnaService.getQnaByProductId(pdNum);
        int qnaPageSize  = 5; // 페이지당 항목 수
        int totalQnAs = qnaList.size(); // 전체 상품 수
        int startRow = (qnaPage - 1) * qnaPageSize; // 시작 인덱스
        int endRow = Math.min(startRow + qnaPageSize, totalQnAs);
        List<QnaReplyDto> qnaRepList = qnaService.getAllQnaReplies();
        List<QDto> paginatedQnAs = qnaList.subList(startRow, endRow);        
        model.addAttribute("qnaRepList", qnaRepList);
        model.addAttribute("products", paginatedQnAs);
        model.addAttribute("currentQnaPage", qnaPage); // 현재 페이지 번호
        model.addAttribute("totalQnaPages", (int) Math.ceil((double) totalQnAs / qnaPageSize)); // 전체 페이지 수
        model.addAttribute("qnaStartPage", Math.max(1, qnaPage - 2)); // 시작 페이지
        model.addAttribute("qnaEndPage", Math.min((int) Math.ceil((double) totalQnAs / qnaPageSize), qnaPage + 2)); // 끝 페이지
        
        System.out.println("qnaRepList : " + qnaRepList);
        
        //구매평 페이징 처리
        List<ProductReviewDto> reviews = PRService.getReviewsByProductId(pdNum);
        // 각 구매평에 해당하는 답글 가져오기
        Map<Integer, List<ReviewReplyDto>> reviewReplies = new HashMap<>();
        for (ProductReviewDto review : reviews) {
            List<ReviewReplyDto> replies = PRService.getReviewReplyByProductId(review.getPr_reviewId());
            reviewReplies.put(review.getPr_reviewId(), replies);
        }
        model.addAttribute("reviewReplies", reviewReplies);
        
        // 구매평 페이지네이션 설정
        int reviewPageSize  = 3; // 페이지당 항목 수
        int totalPReviews = reviewReplies.size(); // 전체 상품 수
        int startRow2 = (reviewPage - 1) * reviewPageSize ; // 시작 인덱스
        int endRow2 = Math.min(startRow2 + reviewPageSize , totalPReviews);
        List<ProductReviewDto> paginatedReviews = reviews.subList(startRow2, endRow2);
        model.addAttribute("reviews", paginatedReviews);
        model.addAttribute("currentReviewPage", reviewPage); // 현재 페이지 번호
        model.addAttribute("totalReviewPages", (int) Math.ceil((double) totalPReviews / reviewPageSize )); // 전체 페이지 수
        model.addAttribute("reviewStartPage", Math.max(1, reviewPage - 2)); // 시작 페이지
        model.addAttribute("reviewEndPage", Math.min((int) Math.ceil((double) totalPReviews / reviewPageSize ), reviewPage + 2)); // 끝 페이지
        
        System.out.println("reviews: "+ reviews);
        System.out.println("reviewReplies : " + reviewReplies);
    
        return "p_details";              
    }
    
    
    @RequestMapping("/s_purchase")    
    public String productPhrchase(@RequestParam("productNum") List<Integer> productNums,
					              @RequestParam("productName") List<String> productNames,
					              @RequestParam("productImage") List<String> productImages,
					              @RequestParam("productQuantity") List<Integer> productQuantities,
					              @RequestParam("productPrice") List<Integer> productPrices,
					              @RequestParam("totalPrice") Integer totalPrice,
					              HttpSession session,
					              Model model) throws SQLException {
    	
    		List<Map<String, Object>> productDetails = new ArrayList<>();
    		
    		for (int i = 0; i < productNums.size(); i++) {
    	        Map<String, Object> productInfo = new HashMap<>();
    	        productInfo.put("productNum", productNums.get(i));
    	        productInfo.put("productName", productNames.get(i));
    	        productInfo.put("productImage", productImages.get(i));
    	        productInfo.put("productQuantity", productQuantities.get(i));
    	        productInfo.put("productPrice", productPrices.get(i));
    	        
    	        productDetails.add(productInfo);
    	    }
    		
    	    model.addAttribute("productDetails", productDetails);
    	    model.addAttribute("totalPrice", totalPrice);  // 단일 총 가격
	        
	        // 각 상품의 정보 출력 (디버깅용)
	        for (int i = 0; i < productNums.size(); i++) {
	            System.out.println("Product Number: " + productNums.get(i));
	            System.out.println("Product Name: " + productNames.get(i));
	            System.out.println("Product Image: " + productImages.get(i));
	            System.out.println("Product Quantity: " + productQuantities.get(i));
	            System.out.println("Product Price: " + productPrices.get(i));
	        }
	        System.out.println("total Price: " + totalPrice);
	       
    	    
    	    //회원정보 가져오기
    	    String memberId = (String) session.getAttribute("userId");
    	    
            if (memberId != null) {
            	MemberDto memberList = mService.getMemberByMemberId(memberId);
            	model.addAttribute("memberList", memberList);
            	
            	System.out.println("memberList :" + memberList);
            } else {
            	System.out.println("Member ID is null");
            }
            
            //주문번호 생성
            Integer uniqueOrderNumber = oService.generateUniqueOrderNumber();
            model.addAttribute("orderNumber", uniqueOrderNumber);
    	    
    	    
    	    // 뷰 이름을 반환하여 해당 뷰를 렌더링
    	    return "s_purchase";       
    }
    
    @PostMapping("/addProduct")
    public ResponseEntity<String> addToCart(@RequestBody CartDto cartDto,
    										HttpSession session) {
        
    	String memberId = cartDto.getMbId();
    	int pdNum = cartDto.getPdNum();
    	
    	System.out.println(memberId + pdNum);
    	
        if (memberId != null) {
        	// 장바구니에 해당 상품이 있는지 확인
        	List<CartDto> existingCartItems = cartService.findCartItemByMemberIdAndProductId(memberId, pdNum);
        	if (existingCartItems != null && !existingCartItems.isEmpty()) {
                // 이미 장바구니에 상품이 있는 경우 경고 메시지 추가
        		return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 장바구니에 담겨있는 상품입니다.");
            } else {
                // 장바구니에 상품이 없으면 추가
            	cartDao.addToCart(cartDto);
            	System.out.println(cartDto);
            }	
        	
        } 
        
        return ResponseEntity.ok("상품이 장바구니에 담겼습니다.");
    }
    
    @RequestMapping("/s_cart")    
    public String shoppingCart(HttpSession session, Model model) {
    		
    		String memberId = (String) session.getAttribute("userId");
    		System.out.println("Member ID: " + memberId);
    		
    		// 회원의 장바구니 내역 가져오기
    		if (memberId != null) {
                List<CartDto> cartList = cartService.getCartByMemberId(memberId);
                model.addAttribute("products", cartList);
                
                System.out.println("Cart List: " + cartList);
            } else {
                System.out.println("Member ID is null");
            }
    		
    		
    	
            return "s_cart";              
    }
    
    
    @RequestMapping("/s_completeBuy")    
    public String completeBuy(@ModelAttribute OrdersDto ordersDto,
    						  Model model) {
    	
		System.out.println("Order Number (odNum): " + ordersDto.getOdNum());
	    System.out.println("Member Number (odMno): " + ordersDto.getOdMno());
	    System.out.println("Amount (odAmount): " + ordersDto.getOdAmount());
	    System.out.println("Member Name (odMname): " + ordersDto.getOdMname());
	    System.out.println("Member Phone (odMphone): " + ordersDto.getOdMphone());
	    System.out.println("Member Email (odMemail): " + ordersDto.getOdMemail());
	    System.out.println("Recipient (odRecipient): " + ordersDto.getOdRecipient());
	    System.out.println("Recipient Phone (odRphone): " + ordersDto.getOdRphone());
	    System.out.println("Recipient Zip Code (odRzcode): " + ordersDto.getOdRzcode());
	    System.out.println("Recipient Address (odRaddress): " + ordersDto.getOdRaddress());
	    System.out.println("Recipient Address 2 (odRaddress2): " + ordersDto.getOdRaddress2());
	    System.out.println("Memo (odMemo): " + ordersDto.getOdMemo());
	    
	    List<ProductOrderDto> productOrders = ordersDto.getProductOrders();
	    if (productOrders != null && !productOrders.isEmpty()) {
	        for (ProductOrderDto productOrder : productOrders) {
	            System.out.println("Product Number: " + productOrder.getPdNum());
	            System.out.println("Product Quantity: " + productOrder.getPdQuantity());
	    
		    // 제품의 pdAmount 업데이트 (수량 감소)
		    PDto product = pService.findByPdNum(ordersDto.getOdNum());
		    if (product != null) {
		        int updatedAmount = product.getPd_amount() - ordersDto.getOdAmount();
		        if (updatedAmount < 0) {
		            updatedAmount = 0; // 재고가 음수가 되지 않도록 처리
		        }
		        product.setPd_amount(updatedAmount);
		        pService.saveProduct(product); // 업데이트 처리
		    } else {
		        System.out.println("Product not found for pdNum: " + ordersDto.getOdNum());
		    }
	    }
	    }
    	
	    oService.insertOrder(ordersDto);
	    
        return "s_completeBuy";              
    }
    
    @PostMapping("/DeleteCart")
    @ResponseBody
    public Map<String, Object> deleteSelectedItems(@RequestBody Map<String, Object> requestData) {
    	
    	List<Integer> pdNums = (List<Integer>) requestData.get("pdNums"); // Integer로 변환
        Boolean eachCheckBox = (Boolean) requestData.get("eachCheckBox"); // Boolean으로 변환
        Map<String, Object> response = new HashMap<>();
        
        System.out.println("pdNums : " + pdNums);
        System.out.println("eachCheckBox : " + eachCheckBox);
        System.out.println("response : " + response);
        
        
        // 체크박스 값 처리
        if (eachCheckBox != null && eachCheckBox) {
            // 체크박스가 선택되었을 때 처리할 로직
            System.out.println("Checkbox is selected");
            boolean isDeleted = cartService.deleteSelectedProducts(pdNums);
            response.put("success", isDeleted);
        } else {
            // 체크박스가 선택되지 않았을 때 처리할 로직
            System.out.println("Checkbox is not selected");
            response.put("success", false);
        }

        return response;
    }
    
    @PostMapping("/remove-soldout")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteSoldOutProducts(@RequestBody List<Integer> pdNums) {
        Map<String, Object> response = new HashMap<>();
        
        boolean success = cartService.deleteSelectedProducts(pdNums); // 서비스 호출
        response.put("success", success);
        
        if (success) {
            response.put("message", "품절 상품이 삭제되었습니다."); // 메시지 추가
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "품절 상품 삭제 실패."); // 메시지 추가
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    
    @RequestMapping("/test1")
    public String root() throws Exception{
        return "test1";
    }
}


package com.shoeper.shoeperApp.myPage.senondHand.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.shoeper.shoeperApp.common.Utils;
import com.shoeper.shoeperApp.member.model.service.MemberService;
import com.shoeper.shoeperApp.member.model.vo.Member;
import com.shoeper.shoeperApp.myPage.senondHand.model.service.SecondHandService;
import com.shoeper.shoeperApp.myPage.brand.model.vo.O_Order;
import com.shoeper.shoeperApp.product.model.vo.Product;
import com.shoeper.shoeperApp.myPage.senondHand.model.vo.Review_ProductInfo;
import com.shoeper.shoeperApp.myPage.senondHand.model.vo.myPageOrderList;
import com.shoeper.shoeperApp.product.model.service.ProductService;
import com.shoeper.shoeperApp.product.model.vo.Attachment;
import com.shoeper.shoeperApp.product.model.vo.Review;
import com.shoeper.shoeperApp.product.model.vo.ReviewAtt;

@SessionAttributes({ "member" })
@Controller
public class SecondHandConrtoller {


	@Autowired
	SecondHandService secondHandService;
	
	@Autowired
	ProductService productService; 
	
	@Autowired
	MemberService memberService;

	@Autowired
	BCryptPasswordEncoder bcrypt;

	@RequestMapping("/myPage/myPage_Info.mp")
	public String myPage_Info( Member member, Model  model ) {
		
		int member_no = member.getMember_no(); 
		// ????????? ?????? ????????? ?????? ?????? ????????? ??????????????? ????????? , ???????????? ??????????????? ??????
	
		List<Integer> pnoList = secondHandService.selectProductSold(); 
	
		
	
		
		 for(int i=0;i<pnoList.size(); i++) {
			 List<Integer> pnomember_no = secondHandService.selectMemberSelling(pnoList.get(i));
			 for(int j=0; j<pnomember_no.size(); j++) {
				 
				 if(member_no == pnomember_no.get(j)) model.addAttribute("popup2",1);
				 
			 }
			 
		 }
					
		return "myPage/myPage_Info";
	}
	// ??????????????? - ??????(??????) ?????? ?????? 
	// 1. ???????????? ??????
	
	@RequestMapping("/myPage/update_Password.do")
	public String update_Password(@RequestParam String password, 
										   @RequestParam String new_password, 	
										   @RequestParam String confirm_password,
										   Member member, Model model) {

		  
		 Member result1 = memberService.selectOneMember(member.getMember_id());

		  // ?????? ????????? ??????????????? db?????? ????????? ??????????????? ???????????????
		  if(bcrypt.matches(password, result1.getMember_pw())) { 
		  
			  String encryptPassword = bcrypt.encode(new_password);
		
			String member_id = member.getMember_id(); 
		  
			  Member tempMember = new Member();
		  
			  tempMember.setMember_id(member_id);
			  tempMember.setMember_pw(encryptPassword);
		  
			  int result2 = secondHandService.updatePassword(tempMember);  // ???????????? ????????????
		  
				  if( result2 > 0) {
					  System.out.println("???????????? ?????? ??????!"); 
					  model.addAttribute("member", member);
					  return "redirect:myPage_Info.mp";
					  
				  } else {
				  
				  System.out.println("???????????? ?????? ??????!"); 
				  return "redirect:myPage_Info.mp"; 
				  }
		  
		}
		  else {  // ???????????? ?????????
		  System.out.println("?????? ??????????????? ???????????? ????????????. / db??? ??????????????? ????????? ??????????????? ?????????");
		  return "redirect:myPage_Info.mp"; 
		  } 
		  }





	// ????????? ??????
//	@RequestMapping("/myPage/update_Email.do")
//	public String update_Email(@RequestParam String update_email, Member member, Model model) {
//
//		System.out.println("current email -> " + member.getEmail());
//
//		if (update_email == null) {
//			System.out.println("Email Null");
//			return "redirect:myPage_Info.mp";
//		}
//
//		if (member.getEmail().equals(update_email)) {
//			System.out.println("same email");
//			return "redirect:myPage_Info.mp";
//		}
//
//		member.setEmail(update_email);
//
//		int result = secondHandService.updateEamil(member);
//
//		if (result > 0) {
//			model.addAttribute("member", member);
//			System.out.println("change email -> " + member.getEmail());
//		}
//
//		return "redirect:myPage_Info.mp";
//	}
	
	@RequestMapping("/myPage/update_Email.do")
	public String myPage_Brand_Info_emUpdate(@RequestParam String email, Member member, Model model) {
		
		String member_id = member.getMember_id();
		
		Member tempMember = new Member();
		
		tempMember.setMember_id(member_id);
		tempMember.setEmail(email);
		
		int result = secondHandService.updateEamil(tempMember);
		
		if( result > 0) {
			  System.out.println("????????? ?????? ??????!"); 
			  model.addAttribute("member", member);
			  return "redirect:myPage_Info.mp";
			  
		  } else {
		  
		  System.out.println("????????? ?????? ??????!"); 
		  return "redirect:myPage_Info.mp"; 
		  }
		
		
	}

	// ???????????? ??????
	@RequestMapping("/myPage/update_Phone.do")
	public String update_Phone(@RequestParam String update_phone, Member member, Model model) {

		String member_id = member.getMember_id();
		
		Member tempMember = new Member();
		
		tempMember.setMember_id(member_id);
		tempMember.setPhone(update_phone);
		
		System.out.println(update_phone);
		
		int result = secondHandService.updatePhone(tempMember);
		
		if( result > 0) {
			  System.out.println("???????????? ?????? ??????!"); 
			  model.addAttribute("member", member);
			  return "redirect:myPage_Info.mp";
			  
		  } else {
		  
		  System.out.println("???????????? ?????? ??????!"); 
		  return "redirect:myPage_Info.mp"; 
		  }
	}

	// ????????????
	@RequestMapping("/myPage/updateAddress.do")
	public String updateAddress(@RequestParam(value = "update_address") String address,
			@RequestParam(value = "update_detail_address") String detailAddress, Member member, Model model) {

		System.out.println(address + " / " + detailAddress);

		String[] newAddress = { address + " " + detailAddress };

		member.setAddress(newAddress);

		int result = secondHandService.updateAddress(member);

		if (result > 0) {
			model.addAttribute(member);

			for (int i = 0; i < newAddress.length; i++) {

				System.out.println(newAddress[i]);

			}
		}

		return "redirect:myPage_Info.mp";
	}

	// ???????????? ??????
	@RequestMapping("/myPage/updateBank.do")
	public String updateBank(@RequestParam(value = "account") String accountNumber,
			@RequestParam(value = "bank_name") String bank_code, Member member, Model model) {

		System.out.println(bank_code); // ????????? ?????? ??????
		System.out.println(accountNumber); // ????????? ????????????

		member.setAccount_number(accountNumber);
		member.setBank_code(bank_code);

		int result = secondHandService.updateBank(member);

		if (result > 0) {
			model.addAttribute(member);
			System.out.println(
					"change Bank_code / Bank_accout -> " + member.getBank_code() + " / " + member.getAccount_number());
		}

		return "redirect:myPage_Info.mp";
	}

	// ?????? ?????? ????????????
	@RequestMapping("/myPage/myPage_Purchased.mp")
	public String selectOrderList(Member member, Model model,
			@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {

		// ??? ???????????? ?????? ??????
		int numPerPage = 12;

		String member_name = member.getMember_name();
		System.out.println(member_name);

		// ?????? ???????????? ?????? ??????
		List<Map<String, String>> list = secondHandService.selectOrderList(cPage, numPerPage, member_name);

		// ?????? ?????? ??????
		int totalContents = secondHandService.purchaseSelectTotalContents();

		String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "myPage_Purchased.mp");
		model.addAttribute("pageBar", pageBar);

		System.out.println("list : " + list);

		model.addAttribute("member", member);
		model.addAttribute("list", list);
		model.addAttribute("numPerPage", numPerPage);
		model.addAttribute("totalContents", totalContents);


		return "myPage/myPage_Purchased";
	}

	// ???????????? ????????? ????????????
	@RequestMapping("/myPage/myPage_Product.mp")
	public String myPageProduct(Member member, Model model,
			@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {

		int member_no = member.getMember_no();

		System.out.println(member_no);

		// ??? ???????????? ?????? ??????
		int numPerPage = 12;

		// ?????? ???????????? ?????? ??????
		List<Map<String, String>> list = secondHandService.selectProductList(cPage, numPerPage, member_no);

		// ?????? ?????? ??????
		int totalContents = secondHandService.selectProductTotalContents();

		String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "myPage_Product.mp");
		model.addAttribute("pageBar", pageBar);

		System.out.println("list : " + list);

		model.addAttribute("member", member);
		model.addAttribute("list", list);
		model.addAttribute("numPerPage", numPerPage);
		model.addAttribute("totalContents", totalContents);



		return "myPage/myPage_Product";
	}

	// ???????????? ??????
	@RequestMapping("/myPage/myPage_Product_Delete.mp")

	public String myPageProductDelete(@RequestParam int productNo, HttpServletRequest req, Model model) {

		System.out.println(productNo);

		String savePath = req.getServletContext().getRealPath("/resources/images/productImgUpload");

		// ???????????? ?????? ??????
		List<Attachment> delList = secondHandService.selectAttachmentList(productNo);

		System.out.println("?????? ?????? : " + delList);

		int result = secondHandService.deleteProduct(productNo);
		String loc = "/myPage/myPage_Product.mp";
		String msg = "";

		if (result > 0) {
			msg = "?????? ??????!";

			for (Attachment a : delList) {
				new File(savePath + "/" + a.getAtt_name()).delete();
			}

		} else {
			msg = "?????? ??????!";
		}

		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);

		return "common/msg";
	}

	// ???????????? ????????????
	@RequestMapping("/myPage/myPage_Sale.mp")
	public String myPageSaleProductList(Member member, Model model,
			@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {

		String member_name = member.getMember_name();
		

		// ??? ???????????? ?????? ??????
		int numPerPage = 12;

		// ?????? ???????????? ?????? ??????
		List<Map<String, String>> list = secondHandService.selectSaleProductList(cPage, numPerPage, member_name);

		// ?????? ?????? ??????
		int totalContents = secondHandService.selectSaleProductTotalContents();

		String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "myPage_Sale.mp");
		model.addAttribute("pageBar", pageBar);

		System.out.println("list : " + list);

		model.addAttribute("member", member);
		model.addAttribute("list", list);
		model.addAttribute("numPerPage", numPerPage);
		model.addAttribute("totalContents", totalContents);


		return "myPage/myPage_Sale";
	}

	@RequestMapping("/myPage/orderStatusChange.do")
	@ResponseBody
	public int OrderStatuschange(@RequestParam int orderNo) {

		System.out.println("?????? ?????? ?????? ???????????? -> " + orderNo);

		int result = secondHandService.updateOrderSaleStatus(orderNo);

		int order_status = 0;

		if (result > 0) {
			order_status = 2;
		}

		return order_status;
	}

	@RequestMapping("/myPage/purchaseStatusChange.do")
	@ResponseBody
	public int purchaseStatusChange(@RequestParam int orderNo) {

		int result = secondHandService.updatePurchaseStatus(orderNo);
		List<Integer> product_no = secondHandService.selectProductByOrderno(orderNo);
		
		
		//int status = secondHandService.selectSecondHandStatus(orderNo);

		System.out.println("?????? ???????????? -> " + orderNo);

		int order_status = 0;

		if (result > 0) {
			order_status = 3;
//			
//			for(int i=0; i<product_no.size(); i++) {
//				
//				secondHandService.deleteSecondProduct(product_no.get(i));
//				System.out.println("????????????"+product_no.get(i)+"????????????");
//			}
		}

		return order_status;
	}

	@RequestMapping("/myPage/myPage_Review.mp")
	public String myPageReview(@RequestParam int ono, @RequestParam int pno, @RequestParam int mno, Model model) {

		System.out.println("Review Controller access");

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("product_no", pno);
		map.put("member_no", mno);

		System.out.println("service??? ????????? map : " + map);

		Review_ProductInfo info = secondHandService.selectReviewInfo(map);

		model.addAttribute("info", info);
		model.addAttribute("orderNo", ono);

		return "myPage/myPage_Review";
	}

	@RequestMapping("/myPage/reviewEnroll.mp")
	public String reviewEnroll(Review review, Model model, HttpServletRequest req,
			@RequestParam(value = "reviewImg", required = false) MultipartFile[] upFiles
			) {
		
		int pno = review.getProduct_no();
		int mno = review.getMember_no();
	
		List<Review> ReviewList = new ArrayList<>();
		int att_level = 0;
		String savePath = req.getServletContext().getRealPath("/resources/images/reviewImgUpload");
		
		for (MultipartFile f : upFiles) {
		
			
			if (f.isEmpty() == false) {
		
				String originName = f.getOriginalFilename();


				try {
						
					f.transferTo(new File(savePath + "/" + originName));

				} catch (IllegalStateException | IOException e) {

					e.printStackTrace();
				}

				
			
				 
				review.setReviewatt_name(originName);
				review.setProduct_no(pno); 
				review.setMember_no(mno);
				
			}
		} 
		if(review.getReviewatt_name()==null) {
			review.setReviewatt_name("NO_IMAGE.png");
			
		}
		
		String msg = "";
		String loc = "";
		System.out.println("image name : " + review.getReviewatt_name());
		productService.updateRating(review);
		int result = secondHandService.insertReview(review);

		if (result > 0) {
			msg = "????????? ??????????????? ?????????????????????.";
			loc = "/product/productDetail.do?product_no="+pno+"&pType=1";
		} else {
			msg = "?????? ????????? ?????????????????????.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		

		return "common/msg";
	
		}

	@RequestMapping("/header/totalSearch.do")
	public String totalSearch(@RequestParam(value = "totalSearch") String totalSearch, Model model,
			@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {
		System.out.println(totalSearch);

		int numPerPage = 12;

		// ?????? ???????????? ?????? ??????
		List<Map<String, String>> result = secondHandService.selectSearchResult(cPage, numPerPage, totalSearch);

		// ?????? ?????? ??????
		int totalContents = secondHandService.selectSearchTotalContents(totalSearch);

		System.out.println(totalContents);

		String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "myPage_Product.mp");
		model.addAttribute("pageBar", pageBar);

		// List<Product> result = secondHandService.selectSearchResult(totalSearch);

		System.out.println("?????? ?????? ?????? -> " + result);

		if (result.size() > 0) {
			model.addAttribute("list", result);
			model.addAttribute("numPerPage", numPerPage);
			model.addAttribute("totalContents", totalContents);
			return "product/searchProduct";
		} else
			return "redirect:/";
	}

}

package com.shoeper.shoeperApp.member.controller;



import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.shoeper.shoeperApp.member.exception.MemberException;
import com.shoeper.shoeperApp.member.model.service.MemberService;
import com.shoeper.shoeperApp.member.model.vo.MailVO;
import com.shoeper.shoeperApp.member.model.vo.Member;



@SessionAttributes({"member"})
@Controller
public class MemberController {

	@Autowired 
	private JavaMailSenderImpl mailSender;

	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder bcrypt; // 해시함수를 이용하여 암호화
	
	// 모달에서 마이페이지로 이동
	@RequestMapping("/member/goMyPage.do")
	public String goMyPage(HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		Member member = (Member) session.getAttribute("member");	 
		
		if ( member.getLogin_type() == 1) return "myPage/myPage_Brand_Info";  // login_type이 1이면 기업 로그인
		else return "myPage/myPage_Info";          							  // 아니면 일반 회원 로그인 
	}
	
	// sns로그인 시 해당 메일주소의 회원이 없다면, 
	// sns로그인으로 얻은 정보와 함께 회원 가입페이지로 가기
	@RequestMapping("/member/snsMemberJoin.do")
	public String kakaoMemberJoin(@RequestParam String member_id, @RequestParam String name,@RequestParam String email,Model model) {
		
		System.out.println("kakao joinForm controller access : " + member_id + "/" + name + "/" + email);
		
		// 임의로 비밀번호 생성
		String pass = randomCode();  
		
		
		model.addAttribute("member_id", member_id);
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		model.addAttribute("pass", pass);
									
		return "member/memberJoin"; //회원가입 페이지
	}
	
	// sns 로그인 시 받아오는 정보로 로그인
	@RequestMapping(value={"member/snsLogin.do", "*/member/snsLogin.do"})
	public String kakaoLogin(@RequestParam String member_id,Model model,SessionStatus status) {
		
		System.out.println("login Access");
		
		// 이미 sns 로그인 계정이 확인되었기 때문에 비밀번호는 검사하지 않음
		Member result = memberService.selectOneMember(member_id);  // 회원아이디로 회원정보 조회
		
		System.out.println("로그인 조회 결과 : " + result);
		
		String loc = "/";
		String msg = "";
		
		if ( result != null ) {
			
			msg = "로그인 성공";
			model.addAttribute("member", result);
				
		} else {
			msg = "아이디를 다시 확인해주세요.";
		}
		
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);  // contextPath 옆에 붙을 단어
		
		return "common/msg";
	}
	
	@RequestMapping("/member/memberJoin.do")
	public String memberJoin() {
		
		return "member/memberJoin";
	}
	
	@RequestMapping("/member/brandJoin.do")
	public String brandJoin() {
		
		return "member/brandJoin";
	}
	
	
	@RequestMapping("/member/joinAccept.do")
	public String memberJoinAccept() {
		
		return "member/joinAccept";  // 약관 동의
	}
	
	// 회원가입 폼 제출 후 
	@RequestMapping("member/memberJoinEnd.do")
	public String memberJoinEnd(SessionStatus status,Member member,Model model) {
		 					// SessionStatus : 컨트롤러에서 세션에 저장된 데이터를 지워서 메모리 누수를 막는 클래스이다.
				System.out.println("joinEnd 들어온 정보 : " + member);
		
		String pass1 = member.getMember_pw();
		String pass2 = bcrypt.encode(pass1);  // 해시함수 암호화
		
		member.setMember_pw(pass2);
		
		int login_type = member.getLogin_type();
		
		
		try {
			
			int result = 0;
			
			if ( login_type == 1 ) result = memberService.insertBrandMember(member);
			else if ( login_type == 2 ) result = memberService.insertMember(member);
			
			String msg = "";
			String loc = "/";
			
			if ( result > 0 ) {
				msg = "회원가입 성공!";
			} else {
				msg = "회원가입 실패";
			}
			
			status.setComplete();  // 세션에 저장된 어트리뷰트 삭제
			
			model.addAttribute("loc", loc);
			model.addAttribute("msg", msg);
			
		} catch ( Exception e ) {
			
			System.out.println("회원가입 에러");
			
			throw new MemberException(e.getMessage());
		}
		
		return "common/msg";
	}
	
	// 아이디 찾기 실행 시 메일로 아이디 보내주기 
	@RequestMapping(value={"member/memberLogin.do", "*/member/memberLogin.do"})
	public String memberLogin(
				@RequestParam String member_id,
				@RequestParam String member_pw,
				Model model
			) {
		
		System.out.println("login Access");
		
		Member result = memberService.selectOneMember(member_id);
		
		System.out.println("로그인 조회 결과 : " + result);
		
		String loc = "/";
		String msg = "";
		
		if ( result != null ) {
			
			if ( bcrypt.matches(member_pw, result.getMember_pw()) ) {
				
				msg = "로그인 성공";
				model.addAttribute("member", result);
				
			} else {
				msg = "아이디 또는 비밀번호를 다시 확인해주세요.";	
			}
		} else {
			msg = "아이디 또는 비밀번호를 다시 확인해주세요.";
		}
		 
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		
		return "common/msg";
	}
	
	@RequestMapping("member/logout.do")
	public String logout(SessionStatus status, Model model) {
		
		String msg = "";
		
		if ( ! status.isComplete() ) {  // isComplete() 확인을 통해 Session내에 지정된 model이 있는지 중복체크
			status.setComplete();
			
			msg = "로그아웃 완료";
		}
		
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping("member/sendIdMail.do") 
	public String sendIdMail(final MailVO vo,Member member,Model model,SessionStatus status) { 
		
		System.out.println("sendMail Controller 접근 : " + member);
		
		Member m;
		String msg;
		
		if ( member.getLogin_type() == 1 ) {
			member.setBrand_name( member.getMember_name() );
			member.setMember_name(null);
		}
		
		m = memberService.selectMemberID(member);
			
		System.out.println("sendMail selectMemberId :: " + m);
			
		if ( m != null ) {
				
			vo.setFrom("mailendingtest@gmail.com");
			vo.setTo(m.getEmail());
			vo.setSubject("[SHOEPER] 아이디 확인 관련 메일");
			
			if ( m.getLogin_type() == 2 ) {
				
				vo.setContents(
						"<html><body><div style=\"width: 400px; height: 300px; padding: 50px; background: black; text-align: center; color: white;\">"
						+ "<h2>SHOEPER에서 알려드립니다.</h2><br>"
						+ "<p>개인 회원이신 " + m.getMember_name() + "님의 아이디는 <p style='font-weight:bolder;'>" 
						+ m.getMember_id() + "</p> 입니다.<br>"
						+ "확인 후 SHOEPER 홈페이지에서 로그인해주세요."
						+ "</p></div>"
						+ "</body></html>"
					);
				
			} else {
				
				vo.setContents(
						"<html><body><div style=\"width: 400px; height: 300px; padding: 50px; background: black; text-align: center; color: white;\">"
						+ "<h2>SHOEPER에서 알려드립니다.</h2><br>"
						+ "<p>브랜드 회원이신 " + m.getBrand_name() + "님의 아이디는 <p style='font-weight:bolder;'>" 
						+ m.getMember_id() + "</p> 입니다.<br>"
						+ "확인 후 SHOEPER 홈페이지에서 로그인해주세요."
						+ "</p></div>"
						+ "</body></html>"
					);
			}
				
			final MimeMessagePreparator preparator = new MimeMessagePreparator() { 
				@Override public void prepare(MimeMessage mimeMessage) throws Exception { 
					final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8"); 
					helper.setFrom("SHOEPER <mailendingtest@gmail.com>"); 
					helper.setTo(vo.getTo()); 
					helper.setSubject(vo.getSubject()); 
					helper.setText(vo.getContents(), true); 
				} 
			}; 
					
			mailSender.send(preparator); 
			
			if ( m.getLogin_type() == 2 ) {
				
				msg = m.getMember_name() + "님의 메일주소로 아이디를 발송했습니다. 확인 후 로그인해주세요";
				
			} else {
				
				msg = m.getBrand_name() + "님의 메일주소로 아이디를 발송했습니다. 확인 후 로그인해주세요";
			}
		
		} else {
				
			msg = "입력하신 이름과 메일주소로 가입된 정보가 없습니다.";
				
		}
		
		// 세션 등록 방지
		status.setComplete();
		
		model.addAttribute("msg", msg);
				
		return "common/msg"; 	
	}
	
	@RequestMapping("member/sendPwMail.do") 
	public String sendPwMail(
				final MailVO vo,
				Member member,
				Model model,
				SessionStatus status
			) { 
		
		System.out.println("sendMail Controller 접근 : " + member);
		
		Member m;
		String msg = "";
		
		if ( member.getLogin_type() == 1 ) {
			member.setBrand_name( member.getMember_name() );
			member.setMember_name(null);
		}
			
		m = memberService.selectMemberID(member);
			
		System.out.println("sendMail selectMemberId :: " + m);
			
		if ( m != null ) {
				
			String newPass = randomCode();
			String encryptpass = bcrypt.encode(newPass);
			
			m.setMember_pw(encryptpass);
			
			int updateResult = memberService.updateNewPass(m);
			
			if ( updateResult > 0 ) {
				
				vo.setFrom("mailendingtest@gmail.com");
				vo.setTo(m.getEmail());
				vo.setSubject("[SHOEPER] 비밀번호 확인 관련 메일");
			
				if ( m.getLogin_type() == 2 ) {
				
					vo.setContents(
							"<html><body><div style=\"width: 400px; height: 300px; padding: 50px; background: black; text-align: center; color: white;\">"
							+ "<h2>SHOEPER에서 알려드립니다.</h2><br>"
							+ "<p>개인 회원이신 " + m.getMember_name() 
							+ "님의 임시 비밀번호는 <p style='font-weight:bolder; font-size:larger;'>" 
							+ newPass + "</p> 입니다.<br>"
							+ "확인 후 SHOEPER 홈페이지에서 로그인해주세요.<br>"
							+ "로그인 후에는 마이페이지 > 회원정보 에서 반드시 비밀번호를 재설정하세요."
							+ "</p></div>"
							+ "</body></html>"
						);
				
				} else {
				
					vo.setContents(
						"<html><body><div style=\"width: 400px; height: 300px; padding: 50px; background: black; text-align: center; color: white;\">"
						+ "<h2>SHOEPER에서 알려드립니다.</h2><br>"
						+ "<p>브랜드 회원이신 " + m.getBrand_name() 
						+ "님의 임시 비밀번호는 <p style='font-weight:bolder; font-size:larger;'>" 
						+ newPass + "</p> 입니다.<br>"
						+ "확인 후 SHOEPER 홈페이지에서 로그인해주세요."
						+ "로그인 후에는 마이페이지 > 회원정보 에서 반드시 비밀번호를 재설정하세요."
						+ "</p></div>"
						+ "</body></html>"
					);
				}
				
				final MimeMessagePreparator preparator = new MimeMessagePreparator() { 
					@Override public void prepare(MimeMessage mimeMessage) throws Exception { 
						final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8"); 
						helper.setFrom("SHOEPER <mailendingtest@gmail.com>"); 
						helper.setTo(vo.getTo()); 
						helper.setSubject(vo.getSubject()); 
						helper.setText(vo.getContents(), true); // true : text를 html형식으로 보냄
					} 
				}; 
					
				mailSender.send(preparator); 
			
				if ( m.getLogin_type() == 2 ) {
				
					msg = m.getMember_name() + "님의 메일주소로 임시 비밀번호를 발송했습니다. 확인 후 로그인해주세요";
				
				} else {
				
					msg = m.getBrand_name() + "님의 메일주소로 임시 비밀번호를 발송했습니다. 확인 후 로그인해주세요";
				}
				
			} else {  // UpdateResult가 0이상이 아니면, 즉 임시 비밀번호로 업데이트에 실패하면
				System.out.println("임시 비밀번호 업데이트 실패");
			}
			
			
		
		} else {
				
			msg = "입력하신 정보로 가입된 정보가 없습니다.";
				
		}
		
		// 세션 등록 방지
		status.setComplete();
		
		model.addAttribute("msg", msg);
				
		return "common/msg"; 	
	}
	
	// 랜덤한 임시 비밀번호 생성 메소드
	public String randomCode() {
		
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 8;
		Random random = new Random();

		String generatedString = random.ints(leftLimit,rightLimit + 1)
		  .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
		  .limit(targetStringLength)
		  .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
		  .toString();

		System.out.println(generatedString);
		
		return generatedString;
	}

	@RequestMapping(value={"member/emailCheck.do", "*/member/emailCheck.do"})
	@ResponseBody
	public String emailCheck(@RequestParam String email) {
		
		System.out.println("kakaoCheck Controller Access");
		
		String member_id = memberService.selectEmailCount(email);
		
		
		return member_id;
	}
	
	// 아이디 중복 확인
	@RequestMapping("/member/checkIdDuplicate.do")
	public void checkIdDuplicate(@RequestParam String id, HttpServletResponse res) throws IOException {
		
		int check = memberService.checkIdDuplicate(id);
		
		boolean data = (check == 0 ? true : false);
		
		res.getWriter().print(data);
	}

	
}
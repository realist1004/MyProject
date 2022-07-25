package com.my.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.dto.MemberDTO;
import com.my.service.MemberService;

@Controller
@RequestMapping("/member/*") // 테이블이 많아질경우 이렇게 지정하여 쓰는것이 더 효율
public class MemberController {
	private static final Logger logger= LoggerFactory.getLogger(MemberController.class);

	@Autowired
	MemberService service;
	@Autowired 
	BCryptPasswordEncoder pwdEncoder;

	private boolean NullPointerException;
	//회원가입 get
	@RequestMapping("register")
	public String gerRegister() throws Exception{
		logger.info("get register");
		return "member/register";
	}
	//회원가입 post
	@RequestMapping("registers")
	public String postRegister(MemberDTO dto) throws Exception{
		logger.info("post register");
		int result = service.idChk(dto);
		try {
			// 요기에서~ 입력된 아이디가 존재한다면 -> 다시 회원가입 페이지로 돌아가기 
			// 존재하지 않는다면 -> register
			if(result == 1) {
				return "/member/register";
			}else if(result == 0) {
				// 회원가입 요청이 들어오면 비밀번호를 암호화하여 dto에 다시 넣어줍니다. 
				//그리고 회원가입 서비스를 실행합니다.
				String inputPass = dto.getUserPass();
				String pwd = pwdEncoder.encode(inputPass);
				dto.setUserPass(pwd);
				
				service.register(dto);
			}			
		} catch (Exception e) {
			throw new RuntimeException();
		}
		
		return "redirect:/";
	
	}
	//로그인 post	
	@RequestMapping("login")// 디버깅모드로 값확인 하기
	public String login(MemberDTO dto, HttpSession session , RedirectAttributes rttr)throws Exception {
		logger.info("post login");
		
		session.getAttribute("member");
		MemberDTO login = service.login(dto);
		// 비밀번호를 암호화 했기 때문에 로그인 할떄 입력한 비번, 암호화된 비번을 비교한 후 처리				
		boolean pwdMatch;
		//틀린 아이디나 입력없이 로그인 할때 login객체에 null값이 들어가서 
		//boolean pwdMatch = pwdEncoder.matches(dto.getUserPass(), login.getUserPass());에서 에러가 남 그래서 조건을 걸어둠	
		if(login != null) {
		pwdMatch = pwdEncoder.matches(dto.getUserPass(), login.getUserPass());
		} else {
		pwdMatch = false;
		}

		if(login != null && pwdMatch == true) {
		session.setAttribute("member", login);
		} else {
		session.setAttribute("member", null);
		rttr.addFlashAttribute("msg", false);
		}
		/*
		 * boolean pwdMatch = pwdEncoder.matches(dto.getUserPass(),
		 * login.getUserPass()); if(login != null && pwdMatch == true) {
		 * session.setAttribute("member", login); } else {
		 * session.setAttribute("member", null); rttr.addFlashAttribute("msg", false); }
		 */
		return "redirect:/";		
	}
	@RequestMapping("logout")
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping("/memberUpdateView")// 로그인을 하면 Member값들을 session에서 이미받고 있기 때문에  파라미터값을 받을 필요없이 쓸수 있음.
	public String registerUpdateView() throws Exception{
		return "member/memberUpdateView";
	}
	//회원정보 수정 post
	@RequestMapping("/memberUpdate")
	public String registerUpdate(MemberDTO dto, HttpSession session) throws Exception{
		service.memberUpdate(dto); // 수정 완료후
		session.invalidate(); // 세션을 끊음.
		return "redirect:/";
	}
	//회원탈퇴 get
	@RequestMapping("/memberDeleteView")
	public String memberDeleteView() throws Exception{
		return "member/memberDeleteView";
	}
	//회원탈퇴 post
	@RequestMapping("/memberDelete")
	public String memberDelete(MemberDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception{
		// 세션에 있는 member를 가져와 member변수에 넣어줍니다.
		//MemberDTO member = (MemberDTO) session.getAttribute("member");
		//세션에 있는 비밀번호
		//String sessionPass=member.getUserPass();
		//dto로 들어오는 비밀번호
		//String dtoPass = dto.getUserPass();
		// 세션비번과 입력한 비번과 일치한지 확인후 처리
		//if(!(sessionPass.equals(dtoPass))) {
		//	rttr.addFlashAttribute("msg", false);
		//	return "redirect:/member/memberDeleteView";
		//}
		service.memberDelete(dto);
		session.invalidate();
		return "redirect:/";
	}
	//회원탈퇴 패스워드체크
	@ResponseBody 
	@RequestMapping("/passChk")
	public boolean passChk(MemberDTO dto) throws Exception{
		MemberDTO login = service.login(dto);
		boolean pwdChk = pwdEncoder.matches(dto.getUserPass(), login.getUserPass());
		return pwdChk;
	}
	//아이디 중복체크
		@ResponseBody
		@RequestMapping("/idChk")
		public int idChk(MemberDTO dto) throws Exception{
			int result = service.idChk(dto);
			return result;
		}
	
}




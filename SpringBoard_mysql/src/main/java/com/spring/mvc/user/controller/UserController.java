package com.spring.mvc.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.mvc.user.model.UserVO;
import com.spring.mvc.user.service.IUserService;

@RestController
@RequestMapping("/user")
public class UserController {

	@Autowired
	private IUserService service;
	
	//회원가입 요청처리
	//Rest-api에서는 Insert -> POST방식이다.
	
	@PostMapping("/")
	public String register(@RequestBody UserVO user) {
		
		System.out.println("/user/POST 요청 발생!");
		System.out.println("param: " + user);
		
		service.register(user);
		
		return "joinSuccess";
	}
	
	//아이디 중복확인 요청 처리
	@PostMapping("/checkId") //서버(브라우저)에서 전달되는 JSON 데이터를 받기 위해서 @RequestBody를 쓴다. 그러면 이것이, 자바객체로 자동 변환 해준다.
	public String checkId(@RequestBody String account) {
		
		System.out.println("/user/checkId: Post 요청 발생!");
		System.out.println("아이디 중복체크 한번해보자!" + account + "확인해보자!");
		String result = null;
		
		Integer checkNum = service.checkId(account);
		if(checkNum == 1) {
			System.out.println("아이디가 중복되었네요");
			result = "NO";
		} else {
			System.out.println("아이디 사용 가능합니다.");
			result = "OK";
		}
		
		
		return result;
		
		
	}
	
	
	
	//회원탈퇴 요청처리
	//@RequestMapping(value="/" , method=RequestMethod.DELETE) 원래방식 .DELETE가 붙는것 기억하라.
	@DeleteMapping("/{account}")
	public String delete(@PathVariable String account) {
		
		System.out.println("delete 요청 발생!" + account + "삭제!");
        service.delete(account);
		return "delSuccess";
	}
	
	//회원정보 조회 요청 처리
	@GetMapping("/{account}") //select(조회는) GET방식
	public UserVO selectOne(@PathVariable String account) {
		
		System.out.println("/user/" + account + "님 조회완료! select문은 get방식이다");
		
		return  service.selectOne(account);
	}
	
	//회원정보 전체조회 요청처리
	@GetMapping("/")
	public List<UserVO> selectAll() {
		
		System.out.println("/user/ 전체 회원목록 조회! 아마도 관리자모드에서 쓸듯하다.");
		
		return service.selectAll();
	}
	
	
	
	
	
}

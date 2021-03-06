package com.spring.mvc.user.repository;

import java.util.List;

import com.spring.mvc.user.model.UserVO;

public interface IUserMapper {

	
	//회원가입 기능
	void register(UserVO user);
	
	//아이디 중복체크 기능 --> count 갯수를 리턴하므로 Integer 타입
	Integer checkId(String account);
	
	//회원 탈퇴 기능
	void delete(String account);
	
	//회원정보 조회기능
	UserVO selectOne(String account);
	
	//회원정보 전체 조회기능
	List<UserVO> selectAll();
}

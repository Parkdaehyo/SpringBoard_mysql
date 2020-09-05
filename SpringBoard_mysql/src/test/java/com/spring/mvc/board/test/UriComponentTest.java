package com.spring.mvc.board.test;

import org.junit.Test;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class UriComponentTest {

	@Test
	public void testUriComp() {
		
		//uri를 쉽게 작성할 수 있도록 도와주는 유틸클래스 UriComponentsBuilder
		
		UriComponents ucp = UriComponentsBuilder.newInstance() //객체생성
						.path("/board/list")
						.queryParam("page", 3)
						.queryParam("countPerPage", 20)
						.queryParam("keyword", "멍멍")
						.queryParam("condition", "title")
						.build();
		
		System.out.println();
		
	}
}

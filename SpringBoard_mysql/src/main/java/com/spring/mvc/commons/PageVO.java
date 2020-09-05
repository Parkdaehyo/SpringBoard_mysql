package com.spring.mvc.commons;

public class PageVO {

	private Integer page; //사용자가 요청한 페이지번호
	private Integer countPerPage; // 한 페이지 당 들어갈 게시물의 수
	
	// /board/list에 접근시 기본적으로 page=1,counterPerPage=10으로 셋팅한다.
	public PageVO() {
		this.page = 1; //처음에 nullPointerException이 뜬 이유는 page를 매개값으로 전달받는값이 없었기 때문이다.
					   // 그렇다면, /board/list 요청시 PageVO를 매개값으로 준다면, 맨 처음에 PageVO 기본생성자가 호출 될때 page=1로 셋팅하면 page값이 있으니까 nullpointerException이 안뜰 것이다.
		this.countPerPage=10;
	}
	
	//클라리언트가 전달한 페이지번호를 데이터베이스의 LIMIT절에 맞는 숫자로 변환.
	public Integer getPageStart() {
		return (this.page-1) * this.countPerPage;
	}

	public Integer getPage() { 
		return page;
	}

	public void setPage(Integer page) { //기본은 1로 셋팅
		
		if(page <= 0) {
			this.page=1;
			return;
			
	}
	this.page = page;

}
	public Integer getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(Integer countPerPage) { //기본은 10으로 셋팅
		if(countPerPage <=0 || countPerPage > 50) {
			this.countPerPage = 10;
			return;
		}
		this.countPerPage = countPerPage;
	}

	@Override
	public String toString() {
		return "PageVO [page=" + page + ", countPerPage=" + countPerPage + "]";
	}
	
	
	
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 포맷팅 관련 태그라이브러리(JSTL/fmt) 문자열,날짜  포맷팅할때 쓰인다.--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <script
 		src="https://code.jquery.com/jquery-3.5.0.min.js" 
		integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="
 		crossorigin="anonymous"></script>


</head>

<style>

.page-active {
	background-color: green;
}

</style>

<body>

	<h1>게시글 목록</h1>

	<table>
	
	<span id="count-per-page" style="float: left;">
	<input class="number" type="button" value="10">
	<input class="number" type="button" value="20">
	<input class="number" type="button" value="30">
	
	</span>
		<tr> 
		<%-- th는 가운데정렬+글씨 진하게 --%>
			<th>#번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
		
	<c:if test="${articles.size() <= 0}">
		<tr>
		<td colspan="5" align="center">
		<strong>검색 결과가 없습니다!!</strong>
		</td>
		</tr>
		</c:if>

	<c:if test="${articles.size() >0}">
	<c:forEach var="b" items="${articles}">
		
		<tr>
		<td>${b.boardNo}</td>
		<td>${b.writer}</td> <!-- BoardController에 content()메서드의 URL 요청시, list.jsp의 boardNO를 넘겨준다.-->
		<td><a href="<c:url value='/board/content/${b.boardNo}${param.page == null ? pc.makeURI(1) : pc.makeURI(param.page)}' />">
		${b.title} </a>
		
		&nbsp;
		<c:if test="${b.newMark}">
		<span class="badge badge-pill badge-danger">new</span>
		</c:if>
		
		</td>
		<td> <!--  a는 오전 오후를 표시한다. -->
		<fmt:formatDate value="${b.regDate}" pattern="yyyy년 MM월 dd일  a hh:mm"/>
		</td>
		<td>${b.viewCnt}</td>
		<td>${b.recommend}</td>
		</tr>
		

	</c:forEach>
	</c:if>
	
	</table>
	
	
			<!-- 페이징 처리 부분  -->
			<!--  prev가 true일 경우에만 보여준다. PageCreator에서 false일경우 -->
				<c:if test="${pc.prev}">
			<a href="<c:url value='/board/list?page=1"'/>" class="page-link ${pc.paging.page == pageNum ? 'page-active' : ''}">처음</a>
			</c:if>
			
			<c:if test="${pc.prev}">
				<a href="<c:url value='/board/list?page=${pc.beginPage-1}&countPerPage=${pc.paging.countPerPage}'/>"> 이전</a>
                      </c:if>
                   
                <!--  페이지 버튼 -->															<!--  pc.paging.page는 현재 위치한 페이지번호 -->
                <c:forEach var="pageNum" begin="${pc.beginPage}" end="${pc.endPage}">
              
                	<a href="<c:url value='/board/list${pc.makeURI(pageNum)}'/>" class="page-link ${pc.paging.page == pageNum ? 'page-active' : ''}" style="margin-top: 0; height: 40px; color: black; border: 1px solid pink;">${pageNum}</a>
                    
                    </c:forEach>  
                   
                <c:if test="${pc.next}">    
                 <a href="<c:url value='/board/list?page=${pc.endPage+1}&countPerPage=${pc.paging.countPerPage}'/>">다음</a>   
			</c:if>
							
				<c:if test="${pc.next}">
			<a href="<c:url value='/board/list?page=31"'/>" class="page-link ${pc.paging.page == pageNum ? 'page-active' : ''}">끝으로</a>
			</c:if>			
						
		<br><a href="<c:url value='/board/write'/>">글쓰기</a><br>
		<br><a href="<c:url value='/board/login'/>">로그인</a><br>
		<br><a href="<c:url value='/board/addMember'/>">회원가입</a><br>
		
		
		
		<select id="condition" class="form-control" name="control">
		<option value="title" ${param.condition == 'title' ? 'selected' : ''}>제목</option>
		<option value="content" ${param.condition == 'content' ? 'selected' : ''}>내용</option>
		<option value="writer" ${param.condition == 'writer' ? 'selected' : ''}>작성자</option>
		<option value="titleContent" ${param.condition == 'titleContent' ? 'selected' : ''}>제목+내용</option>
	
		</select>
		<input type="text" name="keyword" value="${param.keyword}" id="keywordInput" placeholder="검색어">
		<input type="button" value="검색" id="searchBtn">
		
		
	
<script>

const result = "${msg}";

if(result === "regSuccess") {
	alert("게시글 등록이 완료 되었씁니다.");
}else if(result === "delSuccess") {
	alert("게시글 삭제가 완료 되었습니다.");	
}

$(function() {
	
	//목록 개수가 변동하는 이벤트 처리
	$("#count-per-page .number").click(function() {
		console.log("목록 버튼이 클릭됨!");
		console.log($(this).val());
		
		const keyword= "${param.keyword}";
		const condition= "${param.condition}";
		
		let count = $(this).val(); //#count-per-page .number을 가리킨다.
		location.href="/board/list?page=1&countPerPage=" + count
				+ "&keyword=" + keyword
				+ "&condition=" + condition;
		
	});
	
	//검색 버튼 이벤트 처리
	$("#searchBtn").click(function() { //검색버튼을 누르면,
	console.log("검색 버튼이 클릭됨!"); //콘솔이 출력되고,
	const keyword = $("#keywordInput").val(); //input text의 value값을 읽어와서
	console.log("검색어: " + keyword); //콘솔 출력
	
	const condition = $("#condition option:selected").val(); 
	//condition은 select의 id 그리고 그 id의 자식태그  옵션 :은 상태를 의미함(option 상태)의 .selected(선택된값)의 value를 읽어라. //checkbox는 option:checked(radio 옵션)
	console.log("검색조건: " + condition);
	
	location.href="/board/list?keyword=" + keyword
			+"&condition=" + condition; // /board/list에 keyword와 condition을 전송
		
		
	});
	
	//엔터키 입력 이벤트
	$("#keywordInput").keydown(function (key) { //keywordInput에 검색어를 입력하고 key값을 누른다면,
	
		if(key.keyCode == 13) { //근데 그 키값이 엔터라면( 엔터는 13)
			$("#searchBtn").click(); //searchBtn이  실행된다.
		}
	});
	
	
	
});


</script>

</body>
</html>
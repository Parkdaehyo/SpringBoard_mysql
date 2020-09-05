<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
header.masthead {
	
	display: none;
}	
</style>
<br/><br/>
<div class="container">

<div class="row">
  <div class="col-lg-12">
    <div class="card">
      <div class="card-header text-white" style="background-color: #ff52a0;">${article.boardNo}번 게시물 내용</div>
      <div class="card-body">

       
        
          <div class="form-group">
            <label>작성자</label>
            <input type="text" class="form-control" name='writer' value="${article.writer}" readonly>
          </div>
          
          <div class="form-group">
            <label>제목</label>
            <input type="text" class="form-control" name='title' value="${article.title}" readonly>
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" rows="5" name='content' readonly>${article.content}</textarea>
          </div>

         
        <form id="formObj" role="form" action="<c:url value='/board/delete'/>" method="post">  
          
          <!--  삭제하기 위해서 boardNo를 form으로 보낼것이다. post니까 hidden으로 전송한다? -->
          <input type="hidden" name="boardNo" value="${article.boardNo}">
          <input type="hidden" name="page" value="${p.page}">
          <input type="hidden" name="countPerPage" value="${p.countPerPage}">
          
          <!--  button은 get요청 . submit은 post요청으로 처리한다고?--> <!--  onclick== get방식 --> <!-- onclick="location.href='/board/list'" -->
          <input type="button" value="목록" class="btn" id="list-btn"
		style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">&nbsp;&nbsp;
          <!-- 수정해달라는게 아니라 수정화면을 요청함. -->
          <input id="modBtn" type="button" value="수정" class="btn btn-warning" style="color:white;">&nbsp;&nbsp;
          
          <input type="submit" value="삭제" class="btn btn-danger" onclick="return confirm('정말로 삭제하시겠습니까?')">&nbsp;&nbsp;
        </form>

      </div>
    </div>
  </div>
</div>
</div>
<!--  jquery 사용 -->
 <script
 		src="https://code.jquery.com/jquery-3.5.0.min.js" 
		integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="
 		crossorigin="anonymous"></script>

<script>
//form요소, id속성. formObj는 속성값.
//제이쿼리의 시작하는 구문

//수정 완료 알림창 처리
	const msg = "${msg}"; //EL
	if(msg === "modSuccess") {
		
		alert("게시물 수정완료!");
	}
	
$(function() { //익명함수라고 부름
	

	
	//변수는 let, 상수는 const로 선언(ES2015문법) 상수란? 값을 변경하지 않는 것.
	const formElement = $("#formObj"); //formObj: form의 아이디
	
	//목록버튼 클릭 이벤트 처리
	$("#list-btn").click(function() {
		console.log("목록버튼이 클릭됨!");
		location.href='/board/list?page=${p.page}'
				+'&countPerPage=${p.countPerPage}'
				+'&keyword=${p.keyword}'
				+'&condition=${p.condition}';
	});
	
	
	
	
	
	//수정 클릭 이벤트 처리
	//var modifyBtn = document.getElementById("modBtn"); //vanila 자바스크립트 - 원형(원래는 이렇게 써야함.)
	var modifyBtn = $("#modBtn"); // jQuery방식 - jQuery에서 돔객체를 지목 하는 방법 modBtn=수정버튼 
	
	modifyBtn.click(function() { //클릭 했을때 생성되는 이벤트 처리
		console.log("수정 버튼이 클릭됨!");
		formElement.attr("action" , "/board/modify");//attr(속성 , (속성)변경값 ) 태그의 내부 속성을 변경 , action 속성을 /board/modify로 변경
		formElement.attr("method", "get"); //form아이디가 부여되있는 곳에서, 수정 페이지는 get방식으로 요청할 것이므로, method를 get으로 바꿔준다.
		formElement.submit(); //butoon을 submit로 바꿈.
	});
	

	
}); //제이 쿼리의 끝


</script>





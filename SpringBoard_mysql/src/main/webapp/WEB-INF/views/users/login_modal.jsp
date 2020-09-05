<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />     
<!DOCTYPE html>
<html>
<head>
  <!--  이 구문을 넣으면 jQuery를 쓸 수 있다. -->
        <script
 		src="https://code.jquery.com/jquery-3.5.0.min.js" 
		integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="
 		crossorigin="anonymous"></script>
        

   <meta charset="UTF-8">
   <title>회원 가입창</title>
<body>

<h1  style="text-align:center">회원 가입창</h1>
<table  align="center">
    <tr>
       <td width="200"><p align="right">아이디<span id="idChk"></span> </td>
       <td width="400"><input type="text" name="id" id="user_id"></td>
    </tr>
    <tr>
        <td width="200"><p align="right"><span id="pwChk"></span>비밀번호</td>
        <td width="400"><input type="password"  name="pwd" id="password"></td>
    </tr>
    <tr>
        <td width="200"><p align="right"><span id="pwChk2"></span>비밀번호 확인</td>
        <td width="400"><input type="password"  name="pwd" id="password_check"></td>
    </tr>
    <tr>
        <td width="200"><p align="right">이름<span id="nameChk"></span></td>
        <td width="400"><p><input type="text"  name="name" id="user_name"></td>
    </tr>
 <!--    <tr>
        <td width="200"><p align="right">이메일</td>
        <td width="400"><p><input type="text"  name="email"></td>
    </tr> -->
    <tr>
        <td width="200"><p>&nbsp;</p></td>
        <td width="400">
	       <input type="button" id="signup-btn" value="회원가입">
	       <input type="reset" value="다시입력">
       </td>
    </tr>
</table>


</body>

<script>

//start JQuery
$(function() {
	var regex= /[^0-9]/g
	const getIdCheck= RegExp(/^[a-zA-Z0-9]{5,10}$/);
	const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/);
	const getName=  RegExp(/^[가-힣]+$/);
	const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	let chk1 = false, chk2 = false, chk3 = false, chk4 = false; chk5 = false;
	
	//회원가입 검증, 127번 라인
	//ID 입력값 검증.
	//아이디 중복확인 키업 이벤트(한자한자 쓸대마다 실시간으로 서버와 통신하여 아이디를 알려줌)
	$('#user_id').on('keyup', function() { //131번 user_id(input="text") 부분
		if($("#user_id").val() === ""){ //만약 입력창이 공백이라면,
			$('#user_id').css("background-color", "#A5D8FA"); //입력창을 분홍색으로 변경하겠다.
			$('#idChk').html('<b style="font-size:14px;color:red;">[아이디를 입력해주세요.]</b>'); //125번 
			//#idchk <span> </span> 사이에 html이하의 내용을 삽입하라.
			chk1 = false; // chk1 = false로 설정하겠다.
		}
		
		//아이디 유효성검사
		else if(!getIdCheck.test($("#user_id").val())){ //user_id를 test하고, getIdcheck에 있는 문자 내용들과 다르다면,
			$('#user_id').css("background-color", "#A5D8FA"); //핑크색으로 변경
			$('#idChk').html('<b style="font-size:14px;color:red;">[영문자,숫자 포함 5~10자만 가능합니다.]</b>'); //idCheck 부분에 이 문자열 삽입
			chk1 = false; // false로 설정.
		} 
		//ID 중복확인 비동기 처리
		else { //상기 if, else if문에 대한 조건이 걸리지 않았다면, 
			//ID 중복확인 비동기 통신
			const id = $(this).val(); // this == #user_id
			console.log(id);
			
			//통신함수 $.ajax()
			$.ajax({
				type: "POST", //아이디 정보를 숨기기위해서 POST로 보냈다.
				url: "/user/checkId", //어디와 통신하는가?	
				headers: {
	                "Content-Type": "application/json" //서버에 json타입을 보내겠다
	            },
				dataType: "text",  // result값이 ok or No가 들어오므로 text를 써준다.
				data: id, //id하나만 서버에 보내면 된다. String형태라서 그냥 써도된다고?
				success: function(result) { //성공하면 뭐할꺼니?
					if(result === "OK") {
						$("#user_id").css("background-color", "#A5D8FA");
						$("#idChk").html("<b style='font-size:14px; color:green;'>[사용가능한 아이디 입니다.]</b>");						
						chk1 = true;
					} else {
						$("#user_id").css("background-color", "#A5D8FA");
						$("#idChk").html("<b style='font-size:14px; color:red;'>[아이디가 중복었습니다.]</b>");						
						chk1 = false;
					}
				},
				error: function() {
					console.log("통신 실패!");
				}
			});
		}
	});
	
	
	//////////////////////////////회원가입 창 패스워드//////////////////////////////////////
	//패스워드 입력값 검증.
	$('#password').on('keyup', function() {  //패스워드 키업 이벤트 처리
		//비밀번호 공백 확인
		if($("#password").val() === ""){ //공백이라면
		    $('#password').css("background-color", "#A5D8FA"); //레드로 컬러 변경.
			$('#pwChk').html('<b style="font-size:14px;color:red;">[패스워드는 필수입니다.]</b>'); //154번
			chk2 = false;
		}		         
		//비밀번호 유효성검사
		else if(!getPwCheck.test($("#password").val()) || $("#password").val().length < 8){
		    $('#password').css("background-color", "#A5D8FA");
			$('#pwChk').html('<b style="font-size:14px;color:red;">[특수문자 포함 8자이상 입니다.]</b>');
			chk2 = false;
		} else {
			$('#password').css("background-color", "#A5D8FA");
			$('#pwChk').html('<b style="font-size:14px;color:green;">[사용 가능합니다.]</b>');
			chk2 = true;
		}
		
	});
	
	//////////////////////////////회원가입 창 패스워드 확인란//////////////////////////////////////
	//패스워드 확인란 입력값 검증.
	$('#password_check').on('keyup', function() {
		//비밀번호 확인란 공백 확인
		if($("#password_check").val() === ""){ //비밀번호 체크
		    $('#password_check').css("background-color", "#A5D8FA");
			$('#pwChk2').html('<b style="font-size:14px;color:red;">[비밀번호 확인란을 입력해주세요.]</b>');
			chk3 = false;
		}		         
		//비밀번호 확인란 유효성검사
		else if($("#password").val() != $("#password_check").val()){ //비밀번호 와 비밀번호 체크가 맞지 않으면
		    $('#password_check').css("background-color", "#A5D8FA"); // 컬러를 레드로 변경
			$('#pwChk2').html('<b style="font-size:14px;color:red;">[비밀번호를 확인해주세요.]</b>');
			chk3 = false;
		} else {
			$('#password_check').css("background-color", "#A5D8FA"); //공백도 아니고, 
			$('#pwChk2').html('<b style="font-size:14px;color:green;">[사용 가능합니다.]</b>');
			chk3 = true;
		}
		
	});
	
	//이름 입력값 검증.
	$('#user_name').on('keyup', function() {
		//이름값 공백 확인
		if($("#user_name").val() === ""){
		    $('#user_name').css("background-color", "#A5D8FA");
			$('#nameChk').html('<b style="font-size:14px;color:red;">[이름을 입력해주세요.]</b>');
			chk4 = false;
		}		         
		//이름값 유효성검사
		else if(!getName.test($("#user_name").val())){
		    $('#user_name').css("background-color", "#A5D8FA");
			$('#nameChk').html('<b style="font-size:14px;color:red;">[한글만 입력 가능합니다.]]</b>');
			chk4 = false;
		} else { 
			$('#user_name').css("background-color", "#A5D8FA");
			$('#nameChk').html('<b style="font-size:14px;color:green;">[사용 가능합니다.]</b>');
			chk4 = true;
		}
		
	});
	
	
	/////////////////////////////////////////////////////////////////////////////////////
	//회원가입
	$('#signup-btn').click(function() {
		if(chk1 && chk2 && chk3 && chk4) {
		//아이디 정보
		
		const id = $("#user_id").val();
		console.log("id: " + id);
		
		const pw = $("#password").val();
		console.log("pw: " + pw);
		
		const name = $("#user_name").val();
		console.log("name: " + name);
		
		const user = { //JSON 객체는 자바스크립트의 표기법을 따른다.
				
				account: id, //KEY:VALUE 형태인데, KEY 값은 VO멤버와 같도록한다.
				password: pw,
				name: name
		}
		
		$.ajax({
			type: "POST", //서버에 전송하는 HTTP요청 방식 회원가입이니까 POST방식.
			url: "/user/", //서버 요청 URI //UserController의 register 메서드의 PostMapping의 주소값이다. 이 register 메서드는, 이곳 자바스크립트가 적힌곳에서 데이터를 참조해서 결국 Mapper.xml의 SQL문의 id="register" 과 통신하는 것이다.
			headers: {
				"Content-Type": "application/json"
			}, //요청 헤더 정보 , Content-type: 너는 요청할때 어떤 데이터를 보낼건데? 나는 서버에 json 데이터를 보낼거에요.
			dataType: "text", //응답받을 데이터의 형태  - post방식으로 /user/ 요청시 joinSuceess라는 응답이 오기 때문에 text라고 적은 것이다.
			data: JSON.stringify(user), //서버로 전송할 데이터 , //JSON.stringify: 자바스크립트 객체를 JSON형태로 파싱해주는 문법. 보내는순간, @PostMapping("/")
																													 //public String register(@RequestBody UserVO user 작동
			success: function(result) { //result == joinSuccess가 담겨지는 곳, 함수의 매개변수는 통신성공시의 데이터가 저장될 곳. 서버가 준 데이터 결과값이 저장되는곳.
				console.log("통신 성공!: " + result);
				if(result === "joinSuccess") {
					alert("회원가입에 성공했습니다!");
					location.href="/board/list"; // 홈으로 돌려보낸다.
				} else {
					alert("회원가입에 실패했습니다!");
				}
			}, // success function: 통신 성공시 처리할 내용들을 함수 내부에 작성.
			error: function() {
				console.log("통신 실패!");
			} //통신 실패 시 처리할 내용들을 함수 내부에 작성.
		});
			
		} else {
			alert('입력정보를 다시 확인해주세요');
		}		
					
			
	});
		
	//로그인 버튼 클릭이벤트	
		
});	//end JQuery

</script>

</html>

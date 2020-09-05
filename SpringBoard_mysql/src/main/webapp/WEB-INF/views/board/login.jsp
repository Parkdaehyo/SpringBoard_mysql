<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<!--  이 구문을 넣으면 jQuery를 쓸 수 있다. -->
        <script
 		src="https://code.jquery.com/jquery-3.5.0.min.js" 
		integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="
 		crossorigin="anonymous"></script>
        

   <meta charset="UTF-8">
   </head>
   
   <title>로그인창</title>
<body>

<h1  style="text-align:center">로그인</h1>
<table  align="center">
    <tr>
       <td width="200"><p align="right">아이디<span id="idChk"></span> </td>
       <td width="400"><input type="text" name="id" id="signInId"></td>
    </tr>
    <tr>
        <td width="200"><p align="right"><span id="pwChk"></span>비밀번호</td>
        <td width="400"><input type="password"  name="pwd" id="signInPw"></td>
    </tr>
  
    <tr>
        <td width="200"><p>&nbsp;</p></td>
        <td width="400">
	       <input type="button" id="signIn-btn" value="로그인">
       </td>
    </tr>
</table>

</body>

<script>

$(function() {
	
	$("#signIn-btn").click(function() {
		
		
	});
	
	
	
	
});



</script>








</html>
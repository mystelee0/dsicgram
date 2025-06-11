<%@page import="egovframework.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DSICgram 로그인</title>
    <link rel="stylesheet" href="/css/egovframework/login.css">
    <link rel="icon" href="/images/egovframework/example/favicon.ico">
</head>
<body>

<form id="loginForm" name="login">
    <h3>DSICgram에 오신것을 환영합니다!</h3>
    <input type="text" placeholder="아이디" name="id" id="id" />
    <input type="password" placeholder="비밀번호" name="pwd" id="pwd" />
    <button type="button" id="sendBt" onclick="send()">로그인</button>
    <button type="button" id="registerButton" onclick="regist()">회원가입</button>
</form>

<!-- 커스텀알림창 -->
<dialog>
<p class="customText"></p>
<button class="cCloseBtn">확인</button>
</dialog>
<script>
	//새로고침 해야하는지 여부 체크
	let shouldReload = false;
	
	const dialog = document.querySelector("dialog");
	let cText = document.querySelector(".customText");
	const cBtn = document.querySelector(".cCloseBtn");
	
	function cAlert(message,bool){
		shouldReload = bool;
		cText.innerHTML = message;
		dialog.showModal();
		
	}
	
	cBtn.addEventListener("click",()=>{
		dialog.close();
	})
	// 다이얼로그가 닫혔을 때 리로드 실행
	
	
	dialog.addEventListener("close", () => {
	    // dialog가 닫힌 후에 페이지를 리로드
		if(shouldReload){
	   		location.reload();
	    } 
	});
	
	//회원가입창으로 이동
    function regist() {
        location.href = '/join.do';
    }
	
	//로그인 시도
    function send(event) {
        var form = document.getElementById("loginForm");
        var id = document.getElementById("id");
        var pwd = document.getElementById("pwd");
        
        if (pwd.value.trim() == "" || id.value.trim() == "") {
            cAlert("아이디와 비밀번호를 확인해주세요.",false);
            return;
        }
        
        form.action = "/login/authenticate.do";
        form.method = "POST";
        form.submit();
    }
</script>

</body>
</html>
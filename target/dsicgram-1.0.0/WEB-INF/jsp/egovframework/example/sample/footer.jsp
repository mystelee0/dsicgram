<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="footer">
	    <div class="icons">
	        <button class="icon" onclick="location.href='/main.do'">새로고침</button>
	        <button class="icon" id="openModal">글추가</button>
	        <button class="icon" id="logoutBtn">로그아웃‍</button>
	    </div>
	</div>
	
	<script>
		//로그아웃 버튼 클릭 이벤트
		document.querySelector("#logoutBtn").addEventListener("click",()=>{
			cAlert("로그아웃 하시겠습니까?",false,true).then((result)=>{
				if(result){
					axios.get("/logout/.do")
					.then((data)=>{
						if(data.status==200 &&data.data=="logout success" ){
							location.reload();
						}
					});
				}
			});
		});
	</script>
</body>
</html>
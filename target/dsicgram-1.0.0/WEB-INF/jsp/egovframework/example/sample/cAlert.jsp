<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<dialog>
	<p class="customText"></p>
	<div class="cAlertBtn">
		<button class="cCloseBtn">확인</button>
		<button class="cancelBtn" style="display:none;" >취소</button>
	</div>
</dialog>
<script>
//새로고침 해야하는지 여부 체크
let shouldReload = false;

//cAlert 알림창 관련 이벤트
const dialog = document.querySelector("dialog");
let cText = document.querySelector(".customText");
const cancelBtn = document.querySelector(".cancelBtn");
const cBtn = document.querySelector(".cCloseBtn");

function cAlert(message,bool,bool2){
	shouldReload = bool;
	cText.innerHTML = message
	dialog.showModal();
	
	if(bool2==true){
		cancelBtn.style.display="flex";
	}else{
		cancelBtn.style.display="none";
	}
	
	//alert의 확인 및 취소버튼
	return new Promise((resolve) => {
	      // 확인 버튼 클릭시 resolve(true)
	      cBtn.addEventListener("click", () => {
	        dialog.close();
	        resolve(true);
	      });

	      // 취소 버튼 클릭시 resolve(false)
	      cancelBtn.addEventListener("click", () => {
	        dialog.close();
	        cancelBtn.style.display = "none";
	        resolve(false);
	      });

	      // 다이얼로그가 닫히면 호출되는 이벤트
	      dialog.addEventListener("close", () => {
	        if (shouldReload) {
	          location.reload();
	        }
	      });
	    });
}
</script>
</body>
</html>
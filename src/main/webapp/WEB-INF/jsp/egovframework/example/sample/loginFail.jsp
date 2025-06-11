<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	dialog {
	  width: 300px; /* 적당한 너비 */
	  padding: 20px; /* 여백 */
	  border: none; /* 기본 border 없애기 */
	  border-radius: 8px; /* 둥근 모서리 */
	  background-color: #fff; /* 흰색 배경 */
	  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	  text-align: center; /* 텍스트 중앙 정렬 */
	  font-size: 16px; /* 기본 텍스트 크기 */
	  z-index: 1000; /* 다른 요소 위에 위치 */
	}
	
	/* 다이얼로그가 화면 중앙에 오도록 하기 */
	dialog::backdrop {
		background: rgba(0, 0, 0, 0.5); /* 반투명한 배경 */
	  position: fixed; /* 화면에 고정 */
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	}
	
	dialog {
	  position: fixed;
	  width:300px;
	  height:120px;
	  top: 15%;
	  left: 50%;
	  transform: translate(-50%, -50%); /* 화면 중앙 정렬 */
	  margin:0;
	}
	/* 텍스트 스타일 */
	.customText {
	  margin-bottom: 20px; /* 텍스트와 버튼 간 간격 */
	  font-size: 18px; /* 텍스트 크기 */
	  color: #333; /* 텍스트 색 */
	  line-height: 1.5; /* 줄 간격 */
	}
	
	/* 닫기 버튼 스타일 */
	.cCloseBtn {
	  position: absolute;
	  bottom: 10px; /* 아래에서 10px 간격 */
	  right: 10px; /* 오른쪽에서 10px 간격 */
	  padding: 10px 20px;
	  background-color: #33ccff; /* 버튼 색상 */
	  color: white;
	  border: none;
	  border-radius: 5px;
	  cursor: pointer;
	  font-size: 16px;
	  transition: background-color 0.3s ease;
	}
	
	.cCloseBtn:hover {
	  background-color: #4285F4; /* 버튼 hover 시 색상 */
	}
</style>
</head>
<body>
<!-- 커스텀알림창 -->
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

cAlert("등록되지 않은 사용자입니다.",false,false).then((result)=>{
	if(result){
		location.href="/login.do";
	}
});



</script>
</body>
</html>
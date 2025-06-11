<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="/images/egovframework/example/favicon.ico">
    <title>회원가입</title>
    <link rel="stylesheet" href="/css/egovframework/join.css">
</head>
<body>

<div id="wrapper">
    <h3>DSICgram 회원가입</h3>
    <form id="regist" method="post">
        <div class="row">
            <label for="id" class="label"> 아 이 디 :</label>
            <input name="id" id="id" placeholder="영문자 숫자 반드시 포함, 길이  4~10" type="text" maxlength=10>
        </div>
        <div class="row">
        	<button id="idcheckbtn" type="button" onclick="checkId()">아이디 확인</button>
        </div>
        <div class="row">
            <label for="pwd" class="label"> 비 밀 번 호 :</label>
            <input name="pwd" id="pwd" placeholder="비밀번호 입력 (길이 9~16)" type="password" maxlength=10>
        </div>
        <div class="row">
            <label for="pwd2" class="label"> 비 밀 번 호 확 인 :</label>
            <input name="pwd2" id="pwdConfirm" placeholder="비밀번호 확인 (길이 9~16)" type="password" maxlength=10>
        </div>
        <div class="row">
            <label for="nm" class="label"> 이 름 :</label>
            <input name="nm" id="nm" placeholder="이름을 입력하세요 (최대10자리)" type="text" maxlength=10>
        </div>
        <div class="row rowBtn">
            <button type="button" onclick="regist(event)">회원가입</button>
            <button id="cancelBtn" type="button" onclick="location.href='/login.do'">취소</button>
        </div>
            
        
    </form>
</div>
<!-- 커스텀알림창 -->
<dialog>
	<p class="customText"></p>
	<div class="cAlertBtn">
		<button class="cCloseBtn">확인</button>
		<button class="cancelBtn" style="display:none;" >취소</button>
	</div>
</dialog>

<script src="/js/axios-1.x/dist/axios.min.js"></script>
<script>
//nat ip 요청 테스트
(async () => {
	  try {
	    const response = await fetch('https://api.ipify.org?format=json');
	    const data = await response.json();
	    console.log('Outbound IP:', data.ip);
	  } catch (error) {
	    console.error('Error:', error);
	  }
	})();


	document.querySelector("#id").addEventListener("change",()=>{
		idch=false;
	});
	
	//*****************************************************************

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
	//********************************************************
    // 중복 체크 여부
    let idch = false;
    let id = document.getElementById("id");
    let pwd1 = document.getElementById("pwd");
    let pwd2 = document.getElementById("pwdConfirm");
    
    //아이디 유효성 검사1
    function checkIdLength(){
    	if(id.value.length>=4 && id.value.length<=10){
    		return true;
    	}
    	return false;
    }
    //아이디 유효성 검사2
    function checkIdCondition(){
    	return /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$/.test(id.value);
    }
    
    //비밀번호 같은지 검사
    function checkPwd(){
    	//패스워드 위아래와 다름
    	if(pwd1.value != pwd2.value){
    		return false;
    	}
    	return true;
    }
    //비밀번호 길이 검사
    function checkPwdLength(){
    	//패스워드 4~10자리
    	if(pwd1.value.length<9 || pwd1.value.length>16){
    		return false;
    	}
    	
    	return true;
    }
    
    
    function checkId() {
        
        if (id.value === "") {
            cAlert("아이디를 입력해주세요",false);
            return;
        }
        if(!checkIdLength() || !checkIdCondition()){
        	cAlert("아이디 유효성 조건을 확인하세요 \n(4~10글자,영어숫자 포함)",false);
        	return;
        }
        console.log(id.value);

        axios.post("/join/idCheck.do", null, { params: { id: id.value } })
            .then((response) => {
                console.log("response", response);
                if (response.data === true) {
                    cAlert('사용 가능한 아이디입니다',false,false);
                    idch = true;
                } else {
                    cAlert('중복된 아이디입니다',false,false);
                    idch = false;
                }
        });
    }
    //이름 체크
    function checkNm(){
    	let name = document.querySelector("#nm");
    	let str = name.value.trim();
    	if( str == null || str ==""){
    		return false;
    	}
    	return true;
    }
	//회원가입 등록
    function regist(e) {
    	if(!checkPwd()){
        	cAlert("비밀번호를 동일하게 입력해주세요.",false);
        	console.log("위아래 다름");
        	e.preventDefault();
        	return;
        }
    	if(!checkPwdLength()){
    		cAlert("비밀번호는 9~16자리입니다.",false);
    		console.log("길이다름");
    		e.preventDefault();
    		return;
    	}
    	if(!checkNm()){
    		cAlert("이름을 입력해주세요",false);
    		e.preventDefault();
    		return;
    	}
        if (idch === true && document.getElementById("pwd").value !== "") {
            let form = document.getElementById('regist');
            form.method = 'POST';
            form.action = '/join/userinfo.do';
            form.submit();
        } else {
            cAlert('아이디 확인을 해주세요',false);
        }
    }
</script>
<% if (request.getAttribute("message") != null) { %>
    <script>
	
        cAlert('<%=request.getAttribute("message")%>',false,false).then((result)=>{
        	if(result){
        		window.location.href = '<%= request.getAttribute("redirectUrl") %>';
        	}
        })
        
    </script>
<% } %>
</body>
</html>
<%@page import="java.util.Collections"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="egovframework.PostDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="egovframework.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	UserDTO sessionUser = (UserDTO)session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>dsicgram</title>
    <link rel="icon" href="/images/egovframework/example/favicon.ico">
    
    <link rel="stylesheet" href="/css/egovframework/styles.css">
    <link rel="stylesheet" href="/css/egovframework/modal.css">
    <link rel="stylesheet" href="/css/egovframework/updatemodal.css">
    <link rel="stylesheet" href="/css/egovframework/slide.css">
    <link rel="stylesheet" href="/css/egovframework/paging.css">
    
    <!-- <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script> -->
    <script src="/js/axios-1.x/dist/axios.min.js"></script>
    <script>
    // 포스트 수정에서 이미지 토글을 위한 boolean
    let bool = true;
    let targetPostId;
    </script>
</head>
<body>
<!-- 상단  -->
	<div class="navbar">
	    <div class="logo">DSICgram</div>
	    
	    <%
	    	String search = (String)request.getAttribute("search");
	    	if(search == null){
	    		search="";
	    	}
	    %>
	    <div class="search-bar">
	        <input type="text" placeholder="Search... (Press Enter)" id="search" value="<%=search%>">
	    </div>
	    <div id="headerUserInfo">
		    <img src="/static/<%=sessionUser.getImg() %>" onerror="/images/egovframework/example/40.png" alt="Profile" id="profile" class="post-user-image <%=sessionUser.getUserid()%>">
		    <span id="headerUserId"><%=sessionUser.getUserid() %></span>
		    <input type="file" id="fileHidden" hidden>
	    </div>
	</div>
<!-- 포스트 영역  -->
	<div class="main-feed">
	    
	    <script>
    		//base64인코딩 이미지 요청
    		function getImage64(imgNm){
    			let mainImg = document.getElementById(imgNm);
    			
    			axios.get("https://dsicgram-856111275515.us-central1.run.app/images/"+imgNm+"/.do")
    			.then((data)=>{
    				console.log("데이터64",data);
    				mainImg.src = data.data;
    				//mainImg.src = 'data:image/png;base64,'+data.data;
    			});
    		}
    		function getProfile64(){
    			document.querySelectorAll('.post-user-image').forEach((profile)=>{
    				axios.get("/profile/"+profile.classList[1]+"/.do")
	    			.then((data)=>{
	    				console.log("프로필 데이터64",data);
	    				if(data.status==200){
	    					profile.src = data.data;
	    				}
	    				//mainImg.src = 'data:image/png;base64,'+data.data;
	    			}).catch(()=>{
	    				profile.src = "/images/egovframework/example/40.png";
	    			})
    			})
    		}
	    </script>
     	
	    <div class="posts">
	    <% 
	    	//포스트 나열
	    	List<PostDTO> list = (List)request.getAttribute("list");
	    
	    	if(list!=null && list.size()>0){
	    		for(PostDTO po : list){ 
	    			String fnm = po.getFilesNm();
	    			StringTokenizer st = new StringTokenizer(fnm);
	    			
	    %>
	    		
	    		<!-- 포스트 박스 -->
	    		<div class="post" data-id="<%=po.getPostId()%>">
	    			<!-- 포스트 상단 영역 -->
	     		<div class="post-header">
	             	<img src="" onerror="/images/egovframework/example/40.png" alt="Profile" class="post-user-image <%=po.getUserId()%>"/>
	             	<span class="username"><%=po.getUserId() %></span>
	             	<%
	             		if( po.getUserId().equals(sessionUser.getUserid()) ){
	             	%>
		             	<div class="hamburger">
						  <div class="menu-icon" data-id="<%=po.getPostId() %>">
						    <span class="bar"></span>
						    <span class="bar"></span>
						    <span class="bar"></span>
						  </div>
						  <div class="button-container btnContainer<%=po.getPostId()%>">
						    <span class="updatePostBtn" data-id="<%=po.getPostId()%>">수정</span>
						    <span class="deletePostBtn" data-id="<%=po.getPostId()%>">삭제</span>
						  </div>
						</div>
	             	<%
	             		}
	             	%>
	         	</div>
	         	
	         	<!-- 이미지 슬라이드 -->
	         	<div class="image-slider" id="image-slider<%=po.getPostId()%>" data-imgLength="<%=st.countTokens()%>">
	         		<img class="arrow left-arrow" src="/images/egovframework/example/leftarrow.png">
	         		<img class="arrow right-arrow" src="/images/egovframework/example/rightarrow.png">
	         	<%
	         		int imgCnt = st.countTokens();
	         		int index = 1;
	         		while(st.hasMoreTokens()){
	         			String imgnm = st.nextToken();
	         			%>
	         			<span class="showImgIndex n<%=index%>"><%=index++ %>/<%=imgCnt %></span>
	         			<img src="/static/<%=imgnm %>" onerror="" alt="Post Image" class="post-image slide id<%=po.getPostId() %>" id="<%=imgnm%>"/>
	         			<!-- test -->
	         			<!-- <script>getImage64("<%=imgnm%>");</script>-->
	 	        <%
	         		}
	         	%>
	         		
	         	</div>
	         	
         		<!-- 포스트 하단영역 -->
	         	<div class="post-footer">
	              <div class="post-actions">
	                  <div><span class="likeBtn">🤍</span><span class="likeCnt" data-id="<%=po.getPostId()%>">0</span></div>
	                  <div>💬</div>
	                  <div>📤</div>
	              </div>
	              <div class="post-caption"><span class="username"><%=po.getUserId() %></span><testarea class="comment<%=po.getPostId() %> showComment"><%=po.getComment().trim()%></textarea></div>
	          	</div>
	    	</div>
	    		
	    <%
	    		}
	    	}else{%>
	    		<h1>검색 결과가 없습니다...</h1>
	    		<%
	    	}
	    	
	    %>
	    </div>
	</div>
    
    </div>
    <!-- 하단 영역 -->
    <%@ include file="./footer.jsp" %>
</div>
<!-- 페이징 -->
<%@ include file="./paging.jsp" %>

<!-- 생성 모달 창 -->
<%@ include file="./upload.jsp" %>

<!-- 수정 창 -->
<%@ include file="./update.jsp" %>

<!-- 커스텀알림창 -->
<%@ include file="./cAlert.jsp" %>


<script>

	//좋아요 버튼
	document.querySelectorAll('.likeBtn').forEach((el)=>{
		console.log(el.closest('[data-id]').dataset);
		let postId = el.closest('[data-id]').dataset.id;
        
		axios.get("/like/userlike.do?postId="+postId+"&userId=<%=sessionUser.getUserid()%>" )
            .then((res)=>{
            	console.log(res);
            	el.innerText = res.data ? '❤️' : '🤍';
            });
        el.addEventListener('click',(e)=>{
        	axios.post("/like/toggle.do?postId="+postId+"&userId=<%=sessionUser.getUserid()%>" )
            .then((res)=>{
            	e.target.innerText = res.data ?  '❤️' : '🤍';
            	
            	let cntEl = document.querySelector(`.likeCnt[data-id='\${postId}']`);
            	if(res.data){
            		cntEl.innerText = parseInt(cntEl.innerText,10) + 1;
            	}else {
            		cntEl.innerText = parseInt(cntEl.innerText,10) - 1;
            	}
            });
        	
        })
	});
	//좋아요 숫자
 	document.querySelectorAll('.likeCnt').forEach((el)=>{
 		let postId = el.closest('[data-id]').dataset.id;
 		let users="";
		//숫자 로딩
		axios.get(`/like/users.do?postId=\${postId}` )
            .then((res)=>{
            	el.innerText = res.data.length;
            	users=res.data.join(" ");
            });
		
		//숫자클릭 시 목록보이도록
		el.addEventListener('click',(e)=>{
			console.log("숫자 클릭 이벤트");
			let cntUser="";
			axios.get(`/like/users.do?postId=\${postId}` )
            .then((res)=>{
            	el.innerText = res.data.length;
            	cntUser = res.data.join("\n");
            	if(cntUser!="")
    				cAlert(`좋아요!\n \${cntUser}`,false)
            });
			
		});
		
	});
	
	//프로필 이미지 로딩
	getProfile64();


	//프로필 변경 이벤트
	let profile = document.querySelector("#profile");
	let fileHidden = document.querySelector("#fileHidden");
	profile.addEventListener('click',()=>{
		fileHidden.click();
	});
	fileHidden.addEventListener('change',()=>{
		let file = fileHidden.files[0];
		let profileForm = new FormData();
		profileForm.append('file',file);
		axios.post("https://dsicgram-856111275515.us-central1.run.app/profile/<%=sessionUser.getUserid()%>/.do",profileForm)
		.then((data)=>{
			if(data.status==200 && data.data=="update profile"){
				cAlert("프로필 변경 성공!",true);
			}else{
				cAlert(""+data.status+data.data,false);
			}
		})
	});
	
	
	
	//이미지 슬라이드 이벤트 처리
	document.querySelectorAll('.image-slider').forEach(slider => {
		const slides = slider.querySelectorAll('.slide');
		const length = slides.length;
		
		const leftArrow = slider.querySelector('.left-arrow');
		const rightArrow = slider.querySelector('.right-arrow');
		
		
		let index = 0;
		//첫번째 이미지는 보이게 설정
		slides[index].style.display ='block';
		
		//화살표 숨기기
		function displayArrow(){

			if(index == 0){ // 왼쪽 숨기기
				leftArrow.style.display='none';
			}else{
				leftArrow.style.display='block';
			} 
			
			if(index == length-1){ // 오른쪽 숨기기
				rightArrow.style.display='none';
			}else{
				rightArrow.style.display='block';
			}
		}
		
		//처음에 한 번 실행해준다
		displayArrow();
		
		let indexes = slider.querySelectorAll('.showImgIndex');
		indexes.forEach((index)=>{
			index.style.display='none';
		});
		
		//첫번째꺼 기본으로 보이기
		indexes[0].style.display='block';
		
		//왼쪽 오른쪽 클릭 이벤트 발생 시 display처리 변경 및 화살표 보이기함수 호출
		leftArrow.addEventListener('click', function(){
			slides[index].style.display = 'none';
			indexes[index].style.display='none';
			index = (index-1+length)%length;
			slides[index].style.display = 'block';
			indexes[index].style.display='block';
			
			displayArrow();
		})
		rightArrow.addEventListener('click', function(){
			slides[index].style.display = 'none';
			indexes[index].style.display='none';
			index = (index+1+length)%length;
			slides[index].style.display = 'block';
			indexes[index].style.display='block';
			
			displayArrow();
		})
	})
</script>
</body>
</html>
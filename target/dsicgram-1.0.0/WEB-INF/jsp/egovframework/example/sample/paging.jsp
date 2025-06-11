<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="paging" class="paging-container">
    <%
        int cnt = 0;
        cnt = (int)request.getAttribute("cnt");
        int n = 4;  // 한 페이지에 보여줄 항목 개수
        if(cnt % n == 0) cnt -= 1;

        int totalPages = cnt / n + (cnt % n == 0 ? 0 : 1);  // 전체 페이지 수 계산

        int currentPage = (int)request.getAttribute("currentPage");  // 현재 페이지 번호
        if (currentPage <= 0) currentPage = 1;  // 기본값: 1페이지
    %>

    <!-- 이전 페이지 버튼 -->
    <button class="pagebtn prev" <% if(currentPage == 1) out.print("disabled"); %> >이전</button>

    <!-- 페이지 번호 버튼들 -->
    <%
        for (int i = 1; i <= totalPages; i++) {
            String activeClass = (i == currentPage) ? "active" : "";
    %>
        <button class="pagebtn <%= activeClass %>" value="<%=i %>" ><%= i %></button>
    <%
        }
    %>

    <!-- 다음 페이지 버튼 -->
    <button class="pagebtn next" <% if(currentPage == totalPages) out.print("disabled"); %> >다음</button>
</div>
<script>
	//페이징 처리
	let pagebtn=document.getElementsByClassName('pagebtn')
	for(let i=0;i<pagebtn.length;i++)
	pagebtn.item(i).addEventListener('click',(e)=>{
		window.location.href = "/main.do?search="+search.value+"&&page="+e.target.value;
		
	})
	
	document.querySelector(".prev").addEventListener('click',()=>{
		window.location.href = "/main.do?search="+search.value+"&&page="+<%= currentPage - 1 %>;
	})
	document.querySelector(".next").addEventListener('click',()=>{
		window.location.href = "/main.do?search="+search.value+"&&page="+<%= currentPage + 1 %>;
	})
	//검색내용 관련 이벤트
	const search = document.querySelector("#search");
	
	search.addEventListener("keyup",(event)=>{
		if(event.key==='Enter'){
			console.log("엔터키 눌림");
			window.location.href ="/main.do?search="+search.value;
		}
	});
</script>
</body>
</html>
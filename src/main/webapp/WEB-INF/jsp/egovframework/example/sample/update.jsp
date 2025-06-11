<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="updateModalOverlay" class="updateModal-overlay">
	<div class="updateModal-content">
		<p class="updateTitle">게시글 수정(이미지 필수)</p>
		<hr>
		<span id="updateCloseModal" class="updateModal-close">&times;</span>
		<p class="updateFileTitle">추가할 이미지 선택</p>
		<input type="file" id="updateInputFile" multiple/>
		<div id="fileNames"></div>
		<hr>
		<textarea class="updateComment" rows="2" cols="20" maxlength="30" placeholder="텍스트를 입력해주세요 (최대30글자)"></textarea><hr>
		<button id="updatePostBtn" class="updatePost-btn">저장</button>
	</div>
</div>
<script>
//**************수정창**************
let updateopenModalButton;
const updateModalOverlay = document.getElementById("updateModalOverlay");
const updateCloseModalButton = document.getElementById("updateCloseModal");

document.querySelectorAll('.updatePostBtn').forEach(element=>{
	element.addEventListener('click',()=>{
		document.body.classList.add("modal-open");
		updateModalOverlay.classList.add("active");
	})
})

updateCloseModalButton.addEventListener("click", ()=>{
	document.body.classList.remove("modal-open");
	updateModalOverlay.classList.remove("active");
	updateModalOverlay.removeChild(updateModalOverlay.children[0]);
});
updateModalOverlay.addEventListener("click", (event)=>{
	
	if(event.target === updateModalOverlay){
		document.body.classList.remove("modal-open");
		updateModalOverlay.classList.remove("active");
		//기존에 있던 슬라이드 삭제
		event.target.removeChild(event.target.children[0]);
	}
	
});

//햄버거 메뉴 버튼
let menuIcons = document.querySelectorAll('.menu-icon');
menuIcons.forEach(menuIcon => {
    menuIcon.addEventListener('click', function (e) {
      let id = e.target.closest('.menu-icon').getAttribute("data-id");

      let buttonContainer = document.querySelector('.btnContainer'+id);

      buttonContainer.classList.toggle('show');

      // 햄버거 아이콘 애니메이션
      const bars = document.querySelectorAll('.menu-icon .bar');
      bars.forEach(bar => bar.classList.toggle('active'));
    });
  });
//햄버거버튼 토글
document.addEventListener('click', (e)=>{
	if(!e.target.classList.contains("menu-icon") && !e.target.classList.contains("bar")){
		 document.querySelectorAll('.button-container').forEach((element)=>{
			 element.classList.remove('show');
		 })
	}
});

//포스트 수정 삭제 버튼 처리
document.querySelectorAll('.deletePostBtn, .updatePostBtn').forEach(element=>{
	
	
	element.addEventListener('click',function(e){
		
		targetPostId = e.target.getAttribute('data-id');
		console.log("포스트아이디 변경",targetPostId);
		const postId = e.target.getAttribute('data-id');
		//삭제 버튼 클릭
		if(e.target.classList.contains('deletePostBtn')){
			console.log("삭제버튼 클릭",postId);
			cAlert("삭제하시겠습니까?",false,true).then((result)=>{
				if(result){
					axios.delete("/post/"+postId+"/.do")
					.then((data)=>{
						
						console.log(data.status);
						if(data.status==200 && data.data=="delete success"){
							cAlert("삭제 성공!",true);
						}else {
							cAlert("삭제 실패 ㅠ",false);
						}
						
					});
				}else{
					console.log("삭제 취소");
				}
			})
			
		//수정 버튼 클릭
		}else if(e.target.classList.contains('updatePostBtn')){
			//let el = document.getElementById("updateModalOverlay").firstChild;
			//document.getElementById("updateModalOverlay").removeChild(el);
			
			let delImg="";
			console.log("수정버튼 클릭",postId);
			let id = e.target.getAttribute("data-id");
			console.log("아이디 : ",id);
			
			
			let clonedElement = document.getElementById("image-slider"+id).cloneNode(true);
			clonedElement.classList.add("update-image-slider");
			clonedElement.querySelectorAll(".slide").forEach((el)=>{
				el.style.width="500px";
			});
			
			document.getElementById("updateModalOverlay").prepend(clonedElement);
			clonedElement.style.backgroundColor="black";
			
			//이미지 길이
			let len = clonedElement.getAttribute("data-imgLength");
			
			//복사한 슬라이더 element는 이벤트가 없으니 이벤트 설정
			let childrenArray = Array.from(clonedElement.children);
			let slides = childrenArray.filter(child=>child.classList.contains('slide'));
			let length = slides.length;
			
			let leftArrow = childrenArray.filter(child=>child.classList.contains('left-arrow'));
			let rightArrow = childrenArray.filter(child=>child.classList.contains('right-arrow'));
			
			let index = 0;
			//첫번째 이미지는 보이게 설정
			slides[index].style.display ='block';
			
			//인덱스 순번 저장
			for(let i=0;i<length;i++){
				let indexInput = document.createElement("input");
				indexInput.classList.add("input-index");
				indexInput.classList.add("idx"+i);
				indexInput.style.display="none";
				clonedElement.appendChild(indexInput);
			}
			let inputs = clonedElement.querySelectorAll(".input-index");
			//화살표 숨기기
			function displayArrow(){

				if(index == 0){ // 왼쪽 숨기기
					leftArrow[0].style.display='none';
				}else{
					leftArrow[0].style.display='block';
				} 
				
				if(index == length-1){ // 오른쪽 숨기기
					rightArrow[0].style.display='none';
				}else{
					rightArrow[0].style.display='block';
				}
			}
			
			//처음에 한 번 실행해준다
			displayArrow();
			
			//초기 맨 첫번재 화면만 보이도록 설정
			slides[0].style.display = 'block';
			for(let i=1;i<slides.length;i++){
				slides[i].style.display = 'none';
			}
			
			let indexes = clonedElement.querySelectorAll('.showImgIndex');
			indexes.forEach((index)=>{
				index.style.display='none';
				index.style.right='90%';
			});
			
			//첫번째꺼 기본으로 보이기
			indexes[0].style.display='block';
			inputs[0].style.display='block';
			//왼쪽 오른쪽 클릭 이벤트 발생 시 display처리 변경 및 화살표 보이기함수 호출
			leftArrow[0].addEventListener('click', function(){
				slides[index].style.display = 'none';
				indexes[index].style.display='none';
				inputs[index].style.display='none';
				index = (index-1+length)%length;
				slides[index].style.display = 'block';
				indexes[index].style.display='block';
				inputs[index].style.display='block';
				displayArrow();
			})
			rightArrow[0].addEventListener('click', function(){
				slides[index].style.display = 'none';
				indexes[index].style.display='none';
				inputs[index].style.display='none';
				index = (index+1+length)%length;
				slides[index].style.display = 'block';
				indexes[index].style.display='block';
				inputs[index].style.display='block';
				displayArrow();
			})
			
			//삭제버튼 추가
			let btn = document.createElement('button');
			btn.classList.add("deleteImgBtn");
			btn.innerText="삭제";
			clonedElement.appendChild(btn);
			
			//삭제할 이미지 길이
			let delLen=0;
			
			document.querySelector(".deleteImgBtn").addEventListener('click',()=>{
				console.log("처음 delImg",delImg);
				//classList add remove
				if(!slides[index].classList.contains("deleteImg")) {
					slides[index].style.border="2px solid red";
					delImg +=slides[index].getAttribute("id")+" ";
					slides[index].classList.add("deleteImg");
					inputs[index].disabled = true;
					delLen++;
					console.log("삭제에 추가 delImg",delImg);
				}else {
					slides[index].style.border="none";
					delImg = delImg.replace(slides[index].getAttribute("id")+" ","");
					slides[index].classList.remove("deleteImg");
					inputs[index].disabled = false;
					delLen--;
					console.log("삭제에서 지움 delImg",delImg);
				}
			});
			
			
			//파일 변경 시
			let inputFile2 = document.getElementById("updateInputFile");
			let fNames2 = document.getElementById("fileNames");
			let currentFiles2 = [];
			
			let childNodes = fNames2.childNodes; // 모든 자식 노드 가져오기

			// childNodes는 NodeList 객체이기 때문에, forEach가 아닌 일반 for문을 사용하여 역순으로 제거
			for (let i = childNodes.length - 1; i >= 0; i--) {
			  fNames2.removeChild(childNodes[i]);
			}
			
			inputFile2.addEventListener("change",()=>{
				// 선택된 파일들
			    let files = inputFile2.files;
				currentFiles2 = [];
				
				let childNodes = fNames2.childNodes; // 모든 자식 노드 가져오기

				// childNodes는 NodeList 객체이기 때문에, forEach가 아닌 일반 for문을 사용하여 역순으로 제거
				for (let i = childNodes.length - 1; i >= 0; i--) {
				  fNames2.removeChild(childNodes[i]);
				}
				
			    // 선택된 파일들을 currentFiles2에 추가
			    for (let i = 0; i < files.length; i++) {
			        currentFiles2.push(files[i]);

			        // 파일 이름 표시 및 X 버튼 추가
			        let fileItem = createFileItem(files[i]);
			        fNames2.appendChild(fileItem);
			    }
			});
			
			function createFileItem(file) {
			    let fileItem = document.createElement("div");
			    fileItem.classList.add("file-item");

			    let fileImg = document.createElement("img");
			    fileImg.src = URL.createObjectURL(file);
			    fileItem.appendChild(fileImg);
			    
			    // 파일 이름 표시
			    let fileText = document.createElement("span");
			    fileText.textContent = file.name;
			    fileItem.appendChild(fileText);
				
			    // 파일 인덱스 입력
			    let inputIndex = document.createElement("input");
			    inputIndex.classList.add("input-index2");
			    fileItem.appendChild(inputIndex);
			    
			    // X 버튼 생성
			    let removeBtn = document.createElement("button");
			    removeBtn.textContent = "X";
			    removeBtn.classList.add("remove-btn");

			    // X 버튼 클릭 시 해당 파일 삭제
			    removeBtn.addEventListener("click", () => {
			        // currentFiles에서 파일 삭제
			        let index = currentFiles2.indexOf(file);
			        if (index !== -1) {
			            currentFiles2.splice(index, 1);
			        }

			        // 화면에서 파일 항목 제거
			        fNames2.removeChild(fileItem);

			        // 파일 목록을 업데이트
			        updateInputFiles();
			    });

			    fileItem.appendChild(removeBtn);
			    return fileItem;
			}
			// 파일 목록을 inputFile.files에 반영
			function updateInputFiles() {
			    // 새롭게 선택된 파일 목록을 FileList로 변환
			    let dataTransfer = new DataTransfer();
			    currentFiles2.forEach(file => dataTransfer.items.add(file));

			    // inputFile에 새로운 FileList를 할당
			    inputFile2.files = dataTransfer.files;
			}
			
			//내용 불러오기
			let comment = document.querySelector('.comment'+id).innerText;
			console.log(comment);
			document.querySelector('.updateComment').value = comment;
			
			//이미지 인풋 초기화
			document.getElementById("updateInputFile").value="";
			
			//저장버튼 이벤트리스너 등록
			document.querySelector(".updatePost-btn").addEventListener('click',(e)=>{
				let updateForm = new FormData();
				
				let file = document.getElementById("updateInputFile");
				console.log("delLen"+delLen+"len"+len+"filelength"+file.files.length)
				if(delLen==len && file.files.length==0 ){
					cAlert("이미지가 한 개 이상 있어야됩니다.",false);
					e.preventDefault();
					return;
				}
				console.log('최종 delImg',delImg);
				//삭제할 파일 이름
				updateForm.append("del",delImg);
				//커멘트 
				updateForm.append("comment",(document.querySelector('.updateComment').value).toString());
				
				// 파일 추가 업로드
				for(let i=0;i<file.files.length;i++)
					updateForm.append("files",file.files[i]);
				
				// 인덱스
				let imgIndex1 = "";
				let inputs1 = document.querySelectorAll(".input-index");
				inputs1.forEach((i)=>{
					if(!i.disabled){
						if(i.value==""){
							imgIndex1 += 999+" ";
						}else{
							imgIndex1 += i.value+" ";
						}
						
					}
						
				});
				console.log(imgIndex1);
				
				let imgIndex2 = "";
				let inputs2 = document.querySelectorAll(".input-index2");
				inputs2.forEach((i)=>{
					if(!i.disabled){
						if(i.value==""){
							imgIndex2 += 999+" ";
						}else{
							imgIndex2 += i.value+" ";
						}	
					}
				});
				console.log(imgIndex2);
				
				console.log(imgIndex1+imgIndex2);
				
				updateForm.append("index",imgIndex1+imgIndex2);
				//변경사항 없을 시 알림창
				if(delImg=="" && file.files.length==0 && comment == document.querySelector('.updateComment').value && imgIndex1==""){
					cAlert("변경사항이 없습니다!",false);
					return;
				}
				axios.post("/post/"+targetPostId+"/.do", updateForm)
				.then((data)=>{
					console.log("수정요청 결과",data);
					if(data.status==200 && data.data=="update success"){
						cAlert("수정 성공!",true);
					}else {
						cAlert("수정 실패 ㅠ",false);
					}
					
				});
			});
			
		}//수정
	})//이벤트리스너
})
</script>
</body>
</html>
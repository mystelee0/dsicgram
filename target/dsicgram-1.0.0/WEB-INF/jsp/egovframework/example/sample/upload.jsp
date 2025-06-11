<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 생성 모달 창 -->
<div id="modalOverlay" class="modal-overlay">
	<div class="modal-content">
		<span id="closeModal" class="modal-close">&times;</span>
		<p>포스트 업로드(이미지 필수)</p>
		<hr>
		<input type="file" name="files" id="file" multiple />
		<div id="uploadFileNames"></div>
		<hr>
		<textarea type="text" name="comment" id="uploadComment" rows="2" cols="20" maxlength="30" placeholder="텍스트를 입력해주세요 (최대30글자)"></textarea>
		<hr>
		<button type="button" id="uploadBtn" onclick="uploadPost()">등록</button>
		
	</div>
</div>
<script>
	//업로드 함수
	function uploadPost(){
		let file = document.getElementById("file");
		let comment = document.getElementById("uploadComment");
		
		
		
		if(file.files.length===0){
			cAlert("이미지를 선택해주세요!",false);
			return;
		}
		let formData = new FormData();
		console.log(file.files);
		
		//따로따로 올려야 받음
		for(let i = 0;i<file.files.length;i++){
			formData.append("files",file.files[i]);
		}
		
		formData.append("comment",comment.value);
		axios.post("/upload.do", formData, {headers: {'Content-Type': 'multipart/form-data'}})
		.then((res)=>{
			console.log(res);
			if(res.status==200 && res.data=="upload success"){
				cAlert("등록 성공!",true);
			}else{
				cAlert("등록 실패 ㅠ",false);
			}
		})
	}
	
	//생성 모달창
	const openModalButton = document.getElementById("openModal");
	const modalOverlay = document.getElementById("modalOverlay");
	const closeModalButton = document.getElementById("closeModal");
	
	openModalButton.addEventListener("click", ()=>{
		document.body.classList.add("modal-open");
		modalOverlay.classList.add("active");
	});
	closeModalButton.addEventListener("click", ()=>{
		document.body.classList.remove("modal-open");
		modalOverlay.classList.remove("active");
	});
	modalOverlay.addEventListener("click", (event)=>{
		if(event.target === modalOverlay){
			document.body.classList.remove("modal-open");
			modalOverlay.classList.remove("active");
		}
		
	});
	
	// 추가된 파일 항목 생성
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
		
	    // X 버튼 생성
	    let removeBtn = document.createElement("button");
	    removeBtn.textContent = "X";
	    removeBtn.classList.add("remove-btn");

	    // X 버튼 클릭 시 해당 파일 삭제
	    removeBtn.addEventListener("click", () => {
	        // currentFiles에서 파일 삭제
	        let index = currentFiles.indexOf(file);
	        if (index !== -1) {
	            currentFiles.splice(index, 1);
	        }

	        // 화면에서 파일 항목 제거
	        uploadFileNames.removeChild(fileItem);

	        // 파일 목록을 업데이트
	        uploadInputFiles();
	    });

	    fileItem.appendChild(removeBtn);
	    return fileItem;
	}
	
	//input type file에 새롭게 등록
	function uploadInputFiles() {
	    // 새롭게 선택된 파일 목록을 FileList로 변환
	    let dataTransfer = new DataTransfer();
	    currentFiles.forEach(file => dataTransfer.items.add(file));

	    // inputFile에 새로운 FileList를 할당
	    uploadFile.files = dataTransfer.files;
	}
	
	//업로드 파일이름 보이기
	let uploadFile = document.querySelector("#file");
	let uploadFileNames = document.querySelector("#uploadFileNames");
	let currentFiles = [];
	uploadFile.addEventListener("change",()=>{
		// 선택된 파일들
	    let files = uploadFile.files;
		currentFiles = [];
		console.log("files length",files.length);
		
		let childNodes = uploadFileNames.childNodes; // 모든 자식 노드 가져오기

		// childNodes는 NodeList 객체이기 때문에, forEach가 아닌 일반 for문을 사용하여 역순으로 제거
		for (let i = childNodes.length - 1; i >= 0; i--) {
		  uploadFileNames.removeChild(childNodes[i]);
		}
		
	    // 선택된 파일들을 currentFiles에 추가
	    for (let i = 0; i < files.length; i++) {
	        currentFiles.push(files[i]);

	        // 파일 이름 표시 및 X 버튼 추가
	        let fileItem = createFileItem(files[i]);
	        uploadFileNames.appendChild(fileItem);
	    }
	});
</script>
</body>
</html>
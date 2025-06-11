package egovframework.Service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import egovframework.PostDTO;
import egovframework.UserDTO;

public interface PostService {

	//포스트 업로드
	String upload(String userId, MultipartFile[] files, String comment);
	
	//포스트 조회
	List<PostDTO> get(String search, int page);
	
	//포스트 삭제
	String deletePost(String postId);
	
	//포스트 수정
	String updatePost(String postId, MultipartFile[] files, String comment, String del, String index);
	
	//포스트 개수 조회
	int getPostCnt(String search);
}

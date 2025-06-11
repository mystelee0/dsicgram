package egovframework.Repository;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import egovframework.PostDTO;

public interface PostRepository {

	//포스트 저장
	String savePost(PostDTO post);
	
	//포스트 조회
	List<PostDTO> getPost(String search, int page);
	
	//포스트 삭제
	String deletePost(String postId);
	
	//포스트 수정
	String updatePost(String postId, MultipartFile[] files, String comment, String del, String index);
	
	//페이징용 포스트 개수 조회
	int getPostCnt(String search);
}

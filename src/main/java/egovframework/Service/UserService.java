package egovframework.Service;

import org.springframework.web.multipart.MultipartFile;

import egovframework.UserDTO;

public interface UserService {
	
	//아이디 체크
	boolean checkId(String id);
	
	//회원가입
	boolean join(String id, String pwd, String nm);
	
	//로그인
	UserDTO login(String id, String pwd);
	
	//프로필 변경
	boolean changeProfile(String id, MultipartFile file);
	
	//프로필 이미지명 조회
	String getProfile(String id);
}

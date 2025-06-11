package egovframework.Repository;

import egovframework.UserDTO;

public interface UserRepository {
	
	//회원가입
	UserDTO saveUser(String id, String pwd, String nm);
	
	//아이디 확인
	UserDTO findById(String id);
	
	//프로필 이미지명 업데이트
	int updateProfile(String id, String fileName);
	
	//프로필 이미지명 가져오기
	String getProfile(String id);
}

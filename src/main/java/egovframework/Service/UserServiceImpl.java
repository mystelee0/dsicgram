package egovframework.Service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.UserDTO;
import egovframework.Repository.UserRepository;


@Service
public class UserServiceImpl implements UserService{

	UserRepository repo;
	
	@Autowired
	public UserServiceImpl(UserRepository repo) {
		this.repo = repo;
	}



	@Override
	public boolean checkId(String id) {
		
		UserDTO user = repo.findById(id);
		
		//중복 아이디
		if(user == null) {
			return true;
		
		}else {
			return false;
		}
	}



	@Override
	public boolean join(String id, String pwd, String nm) {
		
		UserDTO user = repo.saveUser(id,pwd,nm);
		
		if(user == null) {
			return false;
		}else {
			return true;
		}
		
	}



	@Override
	public UserDTO login(String id, String pwd) {
		UserDTO user = repo.findById(id);
		
		//아이디 비밀번호 체크
		if(user!=null &&user.getUserid().equals(id) && user.getPassword().equals(pwd)) {
			return user;
		}else {
			return null;
		}
			
	}



	@Override
	public boolean changeProfile(String id, MultipartFile file) {
		
		//파일저장
        String ext;
        String uuid;
        String newFileName;
        int index;
        
        //파일 이름 저장
        String filesNm="";
        
        //이미지 새이름 생성
        index = file.getOriginalFilename().lastIndexOf(".");
        ext = file.getOriginalFilename().substring(index + 1);
        uuid = UUID.randomUUID().toString();
        newFileName = uuid + "." + ext;
	 	
        //저장
        try {
			//file.transferTo(new File("C:\\eclipse\\eclipse-workspace\\dsicgram\\src\\main\\resources\\profile\\" + newFileName));
        	file.transferTo(new File("/usr/local/tomcat/webapps/static/" + newFileName));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
        
        filesNm += newFileName + " ";    
        
		int num = repo.updateProfile(id,newFileName);
		if(num==1) return true;
		return false;
		
		
	}



	@Override
	public String getProfile(String id) {
		String fileName = repo.getProfile(id);
		return fileName;
	}

	
	
}

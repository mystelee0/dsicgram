package egovframework.Service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.PostDTO;
import egovframework.Repository.PostRepository;

@Service
public class PostServiceImpl implements PostService{
	
	PostRepository repo;
	
	
	public PostServiceImpl(PostRepository repo) {
		this.repo = repo;
	}


	@Override
	public String upload(String userId, MultipartFile[] files, String comment){
		//파일저장
        String ext;
        String uuid;
        String newFileName;
        int index;
        //파일개수
        int findex=0;
        
        //파일 이름 저장
        String filesNm="";
        
        for (int i = 0; i < files.length; i++) {
            //이미지 새이름 생성
            index = files[findex].getOriginalFilename().lastIndexOf(".");
            ext = files[findex].getOriginalFilename().substring(index + 1);
            uuid = UUID.randomUUID().toString();
            newFileName = uuid + "." + ext;

            //저장
            try {
				//files[findex].transferTo(new File("C:\\eclipse\\eclipse-workspace\\dsicgram\\src\\main\\resources\\static\\" + newFileName));
            	files[findex].transferTo(new File("/usr/local/tomcat/webapps/static/" + newFileName));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "error1";
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "error2";
			}
            
            filesNm += newFileName + " ";
            
            findex++;
        }
        
        PostDTO post = new PostDTO(null, userId, comment, filesNm);
        String result = repo.savePost(post);

        return result;

/* 이미지를 그대로 보내는 예제
        byte[] fileContent=new byte[(int) files[0].getSize()];
        InputStream fis =files[0].getInputStream();
        fis.read(fileContent);
        fis.close();
        return ResponseEntity.ok()
                .body(fileContent);
*/
		
	}


	@Override
	public List<PostDTO> get(String search, int page) {
		
		return repo.getPost(search,page);
		
	}


	@Override
	public String deletePost(String postId) {

		
		return repo.deletePost(postId);
	}


	@Override
	public String updatePost(String postId, MultipartFile[] files, String comment, String del, String index) {
		return repo.updatePost(postId,files,comment,del,index);
	}


	@Override
	public int getPostCnt(String search) {
		return repo.getPostCnt(search);
	}
	
	
	
	
}

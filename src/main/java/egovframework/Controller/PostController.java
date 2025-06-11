package egovframework.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.HttpHeaders;

import org.apache.logging.log4j.core.config.plugins.validation.constraints.Required;
import org.apache.logging.log4j.core.tools.picocli.CommandLine.Parameters;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import egovframework.UserDTO;
import egovframework.Service.PostService;

@Controller
public class PostController {
	
	PostService post;
	
	public PostController(PostService post) {
		this.post = post;
	}



	/**
	 * 게시글 업로드 컨트롤러
	 * 
	 * @param req
	 * @param files
	 * @param comment
	 * @return
	 */
	@RequestMapping("/upload.do")
	@ResponseBody
	public ResponseEntity uploadPost(HttpServletRequest req ,MultipartFile[] files, String comment) {
		System.out.println("파일업로드컨트롤러");
		
		if(comment==null) {
			comment="";
		}
		
		UserDTO user = (UserDTO)req.getSession(false).getAttribute("user");
		if(user==null) {
			System.out.println("세션없음");
			return ResponseEntity.status(HttpStatus.FORBIDDEN).body("upload fail");
		}

		System.out.println(files.length);
		System.out.println(comment);
		
		String result = post.upload(user.getUserid(), files, comment);
		System.out.println("upload result : "+result);
		return ResponseEntity.status(HttpStatus.OK).body("upload success");
	}


	
	
	/**
	 * 이미지 GET 요청
	 * 
	 * base64인코딩 사용
	 * 
	 * @param imgNm
	 * @return
	 * @throws IOException
	 */
	
	@RequestMapping("/images/{imgNm}/.do")
	@ResponseBody
	public String getImage(@PathVariable String imgNm ) throws IOException {
		System.out.println("이미지요청"+imgNm);
		
		//File file=new File("C:\\eclipse\\eclipse-workspace\\dsicgram\\src\\main\\resources\\static\\"+imgNm);
		File file=new File("/usr/local/tomcat/webapps/static/"+imgNm);
		System.out.println("보내줄파일크기"+file.length());
		byte[] bytes= Files.readAllBytes(file.toPath());
		
		String mimeType = Files.probeContentType(file.toPath());
		String base64EncodedImage = Base64.getEncoder().encodeToString(bytes);
		
		return "data:"+mimeType+";base64,"+base64EncodedImage;
		
	}
	
	/**
	 * 게시글 삭제 요청
	 * 
	 * @param postId
	 * @return
	 */
	@DeleteMapping("/post/{postId}/.do")
	public ResponseEntity deletePost(@PathVariable String postId) {
		System.out.println("포스트 삭제요청 "+postId);
		
		String result = post.deletePost(postId);
		if(result.equals("delete success"))
			return ResponseEntity.ok("delete success");
		else return ResponseEntity.status(HttpStatus.FORBIDDEN).body("delete fail");
	}
	
	
	/**
	 * 게시글 수정 요청
	 * 
	 * @param postId
	 * @param files
	 * @param comment
	 * @param del
	 * @return
	 */
	@PostMapping("/post/{postId}/.do")
	public ResponseEntity updatePost(
			@PathVariable String postId, 
			@RequestParam(required = false) MultipartFile[] files ,
			@RequestParam("comment") String comment,
			@RequestParam(required=false) String del, 
			@RequestParam("index") String index ){
		
		if(comment==null) {
			comment="";
		}
		
		System.out.println("추가한 파일길이" +files.length);
		System.out.println("포스트 수정요청 "+postId);
		System.out.println(comment);
		System.out.println(del);
		System.out.println(index);
		
		String result = post.updatePost(postId,files,comment,del,index);
		if(result!=null && result.equals("update success"))
			return ResponseEntity.ok("update success");
		else return ResponseEntity.status(HttpStatus.FORBIDDEN).body("update fail");
	}
}


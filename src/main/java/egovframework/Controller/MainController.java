package egovframework.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import egovframework.UserDTO;
import egovframework.Service.PostService;
import egovframework.Service.UserService;

@Controller
public class MainController {
	
	UserService user;
	PostService post;
	
	@Autowired
	public MainController(UserService user,PostService post) {
		this.user = user;
		this.post = post;
	}


	/**
	 * 메인화면 요청 컨트롤러
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/main.do")
	public String showMain(Model model,
			@RequestParam(value="search",required=false) String search, 
			@RequestParam(value="page",required=false) Integer page) {
		System.out.println("search : "+search);
		System.out.println("page : "+page);
		
		if(page==null) {
			page=1;
		}
		if(search==null) {
			search="";
		}
		
		model.addAttribute("cnt",post.getPostCnt(search));
		
		model.addAttribute("list",post.get(search,page));
		
		model.addAttribute("currentPage",page);
		
		model.addAttribute("search",search);
		
		return "sample/main";
	}
	
	/**
	 * 로그인화면 요청
	 * 
	 * @return
	 */
	@RequestMapping("/login.do")
	public String showLoginPage(HttpServletRequest req) {
		System.out.println("Client ip : "+req.getRemoteAddr());
		String clientIp = req.getHeader("X-Forwarded-For");
		if(clientIp != null)
			System.out.println("Client ip2 : "+clientIp);
		return "sample/login";
	}
	
	/**
	 * 회원가입화면 요청
	 * 
	 * @return
	 */
	@RequestMapping("/join.do")
	public String showJoinPage() {
		// RestTemplate 객체 생성
        RestTemplate restTemplate = new RestTemplate();

        // 요청 보낼 URL
        String url = "https://curlmyip.org/";

        try {
            // GET 요청으로 IP 가져오기
            String publicIP = restTemplate.getForObject(url, String.class);

            // 결과 출력
            System.out.println("Public IP: " + publicIP);
        } catch (Exception e) {
            System.err.println("Failed to fetch IP: " + e.getMessage());
            e.printStackTrace();
        }
		return "sample/join";
	}
	
	/**
	 * 아이디 중복 체크 요청
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/join/idCheck.do")
	@ResponseBody
	public boolean idCheck(String id) {
		System.out.println("[아이디중복체크 컨트롤러]");
		return user.checkId(id);
	}
	
	/**
	 * 회원가입 요청 컨트롤러
	 * 
	 * @param model
	 * @param id
	 * @param pwd
	 * @param nm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/join/userinfo.do")
	public String signUp(Model model, String id,String pwd,String nm) throws IOException {
		System.out.println("회원가입 받은 값 : "+id + " "+pwd+" "+nm);
		boolean bool = user.join(id, pwd, nm);
		
		String message = bool ? "로그인 해주세요" : "회원가입 실패!";
        model.addAttribute("message", message);
        model.addAttribute("redirectUrl", bool ? "/login.do" : "/join.do");

        return "sample/join";
	}
	
	
	/**
	 * 로그인 요청 컨트롤러
	 * 
	 * @param req
	 * @param res
	 * @param model
	 * @param id
	 * @param pwd
	 * @return
	 */
	@RequestMapping("/login/authenticate.do")
	public String logIn(HttpServletRequest req, HttpServletResponse res , Model model, String id,String pwd) {
		System.out.println("로그인 받은 값 : "+id + " "+pwd);
		
		UserDTO loginUser = user.login(id, pwd); 
		
		//로그인실패
		if(loginUser==null) {
			System.out.println("로그인체크 사용자조회 null");
			return "/sample/loginFail";
		}else {//로그인 성공
			HttpSession session = req.getSession();
			session.setAttribute("user", loginUser);
			model.addAttribute("status",true);
			model.addAttribute("user", loginUser);
			return "redirect:/main.do";
		} 
	}
	
	/**
	 * 로그아웃 요청 컨트롤러
	 * 
	 * @param req
	 * @return
	 */
	@RequestMapping("/logout/.do")
	public ResponseEntity logOut(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.removeAttribute("user");
		return ResponseEntity.ok("logout success");
	}
	

	/**
	 * 프로필 변경 요청 컨트롤러
	 * 
	 * @param req
	 * @param userId
	 * @param file
	 * @return
	 */
	@PostMapping("/profile/{userId}/.do")
	public ResponseEntity changeProfile(HttpServletRequest req,@PathVariable String userId, MultipartFile file) {
		HttpSession session = req.getSession();
		UserDTO u = (UserDTO)session.getAttribute("user");

		if(!u.getUserid().equals(userId)) {
			System.out.println("아이디 불일치");
			return ResponseEntity.status(HttpStatus.FORBIDDEN).body("update profile fail");
		}
		
		boolean bool = user.changeProfile(userId,file);
		if(bool) {
			return ResponseEntity.ok("update profile");
		}else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).body("update profile fail");
		}
		
	}
	/**
	 * 프로필 이미지 요청 컨트롤러
	 * 
	 * @param userId
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/profile/{userId}/.do")
	public ResponseEntity getProfile(@PathVariable String userId) throws IOException {

		String fileName = user.getProfile(userId);
		File file=new File("/usr/local/tomcat/webapps/static/"+fileName);
		//File file=new File("/usr/local/tomcat/webapps/ROOT/profile/"+fileName); 됨
		//File file=new File("ROOT/profile/"+fileName); 안됨
		//File file=new File("profile/"+fileName); 안됨
		if(file.length()==0) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(""); 
		}
		byte[] bytes= Files.readAllBytes(file.toPath());
		
		String mimeType = Files.probeContentType(file.toPath());
		String base64EncodedImage = Base64.getEncoder().encodeToString(bytes);
		
		return ResponseEntity.ok("data:"+mimeType+";base64,"+base64EncodedImage); 
		
	}
}

package egovframework;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 
 * @author 이민성_N01
 *
 * 기능 : 로그인이 안되어있으면 로그인 페이지로 이동
 */
public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session= request.getSession();
		UserDTO user=(UserDTO)session.getAttribute("user");
		
		//로그인 된 상태
		if(session!=null&&user!=null) {
			System.out.println("prehandle login");
			return true;//super.preHandle(request, response, handler);
		}
		//로그인 안된 상태
		else {
			System.out.println("prehandle not login");
			response.sendRedirect("/login.do");
			return false;
		}
		
		
	}

	
	
}

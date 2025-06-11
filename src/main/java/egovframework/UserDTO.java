package egovframework;

public class UserDTO {

	String userid;
	String password;
	String usernm;
	String img;

	public UserDTO() {
		
	}
	
	public UserDTO(String userid, String password, String usernm) {
		super();
		this.userid = userid;
		this.usernm = usernm;
		this.password=password;
	}
	
	public UserDTO(String userid, String password, String usernm, String img) {
		super();
		this.userid = userid;
		this.password = password;
		this.usernm = usernm;
		this.img = img;
	}

	/**
	 * 유저 아이디 Getter Setter
	 * 
	 */
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	/**
	 * 유저 비밀번호 Getter Setter
	 * 
	 */
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * 유저 닉네임 Getter Setter
	 * 
	 */
	public String getUsernm() {
		return usernm;
	}
	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	
}

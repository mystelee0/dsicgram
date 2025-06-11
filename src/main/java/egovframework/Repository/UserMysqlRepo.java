package egovframework.Repository;

import java.io.File;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import egovframework.PostDTO;
import egovframework.UserDTO;


@Repository
public class UserMysqlRepo implements UserRepository {

	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public UserDTO saveUser(String id, String pwd, String nm) {
		try {
			jdbcTemplate.update("insert into user (id,pw,nm) values(?,?,?)",
					id,pwd,nm);
			
			return jdbcTemplate.queryForObject("select * from user where id=?",
					(resultSet, rowNum) -> {
						UserDTO newuser=new UserDTO();
						newuser.setUserid(resultSet.getString("id"));
						newuser.setPassword(resultSet.getString("pw"));
						newuser.setUsernm(resultSet.getString("nm"));
						return newuser;
					},
					id);
			
		}catch(Exception e) {
			System.out.println(e);
			
		}
		return null;
	}

	@Override
	public UserDTO findById(String id) {
		try {
			UserDTO user = jdbcTemplate.queryForObject("select * from user where id=?", (resultSet,rowNum)->{
				UserDTO find=new UserDTO();
				find.setUserid(resultSet.getString("id"));
				find.setPassword(resultSet.getString("pw"));
				find.setUsernm(resultSet.getString("nm"));
				find.setImg(resultSet.getNString("img"));
				return find;
			},id);

			return user;
			}catch(Exception e) {
				System.out.println(e);
				return null;
			}
		
	}

	@Override
	public int updateProfile(String id, String fileName) {
		
		//기존 프로필 사진 삭제
		String oldFileName = jdbcTemplate.queryForObject("select img from user where id=?", (resultSet,rowNum)->{
			return resultSet.getString("img");
		},id);
		
		//File file = new File("C:\\eclipse\\eclipse-workspace\\dsicgram\\src\\main\\resources\\profile\\" + oldFileName);
		File file=new File("/usr/local/tomcat/webapps/static/"+oldFileName);
		
		
		if( file.exists() ){
    		if(file.delete()){
    			System.out.println("파일삭제 성공");
    		}else{
    			System.out.println("파일삭제 실패");
    		}
    	}else{
    		System.out.println("파일이 존재하지 않습니다.");
    	}
        	
		//새로운 파일이름 업데이트
		String sql = "update user set img=? where id=?";
		
		int num = jdbcTemplate.update(sql, fileName, id);
		if(num==1) {
			return num;
		}else {
			return num;
		}
	}

	@Override
	public String getProfile(String id) {
		return jdbcTemplate.queryForObject("select img from user where id=?", (resultSet,rowNum)->{
			return resultSet.getString("img");
		},id);
	}
	
	

	
}

package egovframework.Repository;

import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import egovframework.PostDTO;
import egovframework.UserDTO;

@Repository
public class PostMysqlRepo implements PostRepository {
	
	/**
	 * spring jdbctemplate 사용
	 */
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	
	@Override
	public String savePost(PostDTO post) {
		String sql = "insert into post(img,comment,userid) values(?,?,?)";
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		System.out.println("savePost 시작부분");
		jdbcTemplate.update(connection ->{
			//자동 증가 키
			PreparedStatement ps = connection.prepareStatement(sql,new String[]{"postid"});
			ps.setString(1,post.getFilesNm());
			ps.setString(2,post.getComment());
			ps.setString(3,post.getUserId());
			return ps;
		},keyHolder);
		
		String postId = keyHolder.getKey().toString();
		System.out.println("postId : "+postId);
		
		return null;
	}

	@Override
	public List<PostDTO> getPost(String search, int page) {
		String sql = "select * from post ";
		
		if(search!=null) {
			sql += "where userid like '%"+search+"%' ";
		}
		
		sql+="order by postid desc ";
		
		int n=4;
		int start=(page-1)*n;
		int end=page*n+1;
		sql+="limit "+n+" offset "+start;
		
		System.out.println(sql);
		
		
		return jdbcTemplate.query(sql,
				(resultSet,rowNum)->{
					PostDTO post = new PostDTO();
					post.setPostId(resultSet.getString("postid"));
					post.setFilesNm(resultSet.getString("img"));
					post.setComment(resultSet.getString("comment"));
					post.setUserId(resultSet.getString("userid"));
					return post;
				});
	}


	@Override
	public String deletePost(String postId) {
		
		// 이미지파일 삭제
		String filesNm = jdbcTemplate.queryForObject("select * from post where postid=?",
				(resultSet, rowNum) -> {
					String str = "";
					str+=resultSet.getString("img");
					return str;
				},
				postId);
		
		StringTokenizer st = new StringTokenizer(filesNm);
		
		while(st.hasMoreTokens()) {
			String fileName = st.nextToken();
			
			//File file = new File("C:\\eclipse\\eclipse-workspace\\dsicgram\\src\\main\\resources\\static\\"+fileName);
			File file=new File("/usr/local/tomcat/webapps/static/"+fileName);
			if(!file.delete()) {
				System.out.println("이미지 삭제 실패1");
				return "delete fail";
			}
		}
		
		// 디비에서 포스트정보 삭제
		String sql = "delete from post where postid = ?";
		int delPost = jdbcTemplate.update(sql,postId);
		
		if(delPost==1) {
			System.out.println("디비 포스트 삭제 완료");
			return "delete success";
		}
			
		else {
			System.out.println("디비 포스트 삭제 실패");
			return "delete fail";
		}
	}


	@Override
	public String updatePost(String postId, MultipartFile[] files, String comment, String del, String index2) {
		//파일저장
        String ext;
        String uuid;
        String newFileName;
        int index;
        //파일개수
        int findex=0;
		
        //파일 이름 저장
        String newFilesNm="";
        
        for (int i = 0; i < files.length; i++) {
            //이미지 새이름 생성
            index = files[findex].getOriginalFilename().lastIndexOf(".");
            ext = files[findex].getOriginalFilename().substring(index + 1);
            uuid = UUID.randomUUID().toString();
            newFileName = uuid + "." + ext;

            //저장
            try {
				//files[findex].transferTo(new File("C:\\eclipse\\eclipse-workspace\\dsicgram\\src\\main\\resources\\static\\" + newFileName));
            	files[findex].transferTo(new File("/usr/local/tomcat/webapps/static/"+newFileName));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "error1";
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "error2";
			}
            
            //새로 저장한 파일들의 이름
            newFilesNm += newFileName + " ";
            
            findex++;
        }
        
		//삭제할 파일 처리
		StringTokenizer st = new StringTokenizer(del);
		
		String filesNm = jdbcTemplate.queryForObject("select * from post where postid=?",
				(resultSet, rowNum) -> {
					String str = "";
					str+=resultSet.getString("img");
					return str;
				},
				postId);
		
		while(st.hasMoreTokens()) {
			String fileName = st.nextToken();
			System.out.println(fileName);
			filesNm = filesNm.replace(fileName, "");
			//File file = new File("C:\\eclipse\\eclipse-workspace\\dsicgram\\src\\main\\resources\\static\\"+fileName);
			File file=new File("/usr/local/tomcat/webapps/static/"+fileName);
			if(!file.delete()) {
				System.out.println("이미지 삭제 실패2");
				return "update fail";
			}
		}
		System.out.println("삭제 후 결과"+filesNm);
		
		//새로운 파일명 추가
		filesNm+=newFilesNm;
		
		if(index2!=null || !index2.equals("")) {
			//추가 삭제 다 하고 정렬
			StringTokenizer st1 = new StringTokenizer(index2);
			StringTokenizer st2 = new StringTokenizer(filesNm);
	
			int[] numbers = new int[st1.countTokens()];
			String[] letters = new String[st2.countTokens()];
			for(int i=0;i<numbers.length;i++) {
				numbers[i]=Integer.parseInt(st1.nextToken());
			}
			for(int i=0;i<letters.length;i++) {
				letters[i]=st2.nextToken();
			}
			
			Integer[] indices = new Integer[numbers.length];
	        for (int i = 0; i < numbers.length; i++) {
	            indices[i] = i; // 각 인덱스를 저장
	        }
	        
	        Arrays.sort(indices, Comparator.comparingInt(i -> numbers[i]));
	        
	        String[] sortedLetters = new String[letters.length];
	        for (int i = 0; i < indices.length; i++) {
	            sortedLetters[i] = letters[indices[i]]; // 정렬된 인덱스를 기반으로 문자 배열에 값을 넣음
	        }
	        
	        // 결과 출력
	        System.out.println(Arrays.toString(sortedLetters));
			
	        String sortedNm="";
	        //순서변경한 파일이름
	        for(int i=0;i<sortedLetters.length;i++) {
	        	sortedNm+=sortedLetters[i]+" ";
	        }
			filesNm=sortedNm;
		}
		
		String sql = "update post set comment=?, img=? where postid=?";
		
		int num = jdbcTemplate.update(sql, comment, filesNm, postId);
		if(num==1) {
			return "update success";
		}else {
			return "update fail";
		}
		
		
	}


	@Override
	public int getPostCnt(String search) {
		String sql = "select count(*) from post";
		if(search!=null || search!="") {
			sql+=" where userid like '%"+search+"%'";
		}
		System.out.println(sql);
		int cnt=jdbcTemplate.queryForObject(sql, Integer.class);
		return cnt;
	}

	
	
}

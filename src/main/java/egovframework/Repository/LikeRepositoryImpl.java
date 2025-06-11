package egovframework.Repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LikeRepositoryImpl implements LikeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean isLiked(int postId, String userId) {
    	System.out.println("islike 메소드");
        String sql = "SELECT COUNT(*) FROM likes WHERE postid = ? AND userid = ?";
        
        Integer count=0;
        try {
        	count = jdbcTemplate.queryForObject(sql, Integer.class, postId, userId);
        }catch(Exception e) {
        	System.out.println("sql에러 발생 "+e);
        }
        
        return count != null && count > 0;
    }

    @Override
    public void addLike(int postId, String userId) {
    	System.out.println("add like 메소드");
        String sql = "INSERT INTO likes (postid, userid) VALUES (?, ?)";
        jdbcTemplate.update(sql, postId, userId);
    }

    @Override
    public void removeLike(int postId, String userId) {
    	System.out.println("remove like 메소드");
        String sql = "DELETE FROM likes WHERE postid = ? AND userid = ?";
        jdbcTemplate.update(sql, postId, userId);
    }

    @Override
    public List<String> findUsersByPostId(int postId) {
        String sql = "SELECT userid FROM likes WHERE postid = ?";
        return jdbcTemplate.queryForList(sql, String.class, postId);
    }
}
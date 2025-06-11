package egovframework.Service;

import java.util.List;

public interface LikeService {
	boolean userLike(int postId,String userId);    // 유저가 해당 글에 하트를 눌렀는지 판단
    boolean toggleLike(int postId, String userId); // 하트를 토글 (하얀->빨간, 빨간->하얀)
    List<String> getUsersWhoLiked(int postId);     // 하트를 누른 사용자 목록 조회
}

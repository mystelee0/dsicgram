package egovframework.Repository;

import java.util.List;

public interface LikeRepository {
    boolean isLiked(int postId, String userId); // 특정 사용자가 하트를 눌렀는지 확인
    void addLike(int postId, String userId);   // 하트 추가
    void removeLike(int postId, String userId); // 하트 제거
    List<String> findUsersByPostId(int postId); // 게시글 ID로 사용자 목록 조회
}
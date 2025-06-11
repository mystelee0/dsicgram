package egovframework.Service;

import egovframework.Repository.LikeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class LikeServiceImpl implements LikeService {

    @Autowired
    private LikeRepository likeRepository;

    @Override
	public boolean userLike(int postId, String userId) {
    	if ( likeRepository.isLiked(postId, userId)) {
            return true;
        } else {
            return false;
        }
		
	}

	@Override
    public boolean toggleLike(int postId, String userId) {
    	System.out.println("like service togglelike");
        if (likeRepository.isLiked(postId, userId)) {
            likeRepository.removeLike(postId, userId);
            return false;
        } else {
            likeRepository.addLike(postId, userId);
            return true;
        }
    }

    @Override
    public List<String> getUsersWhoLiked(int postId) {
        return likeRepository.findUsersByPostId(postId);
    }
}
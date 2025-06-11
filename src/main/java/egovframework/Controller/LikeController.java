package egovframework.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import egovframework.Service.LikeService;




@RestController
@RequestMapping("/like")
public class LikeController {

    @Autowired
    public LikeService likeService;
    
    @GetMapping("/userlike.do")
    public boolean userLike(@RequestParam int postId, @RequestParam String userId) {
    	System.out.println("[ Likecontroller ]");
        return likeService.userLike(postId, userId);
    }
    
    @PostMapping("/toggle.do")
    public boolean toggleLike(@RequestParam int postId, @RequestParam String userId) {
    	System.out.println("[ Likecontroller ]");
        return likeService.toggleLike(postId, userId);
    }

    @GetMapping("/users.do")
    public List<String> getUsersWhoLiked(@RequestParam int postId) {
        return likeService.getUsersWhoLiked(postId);
    }
}

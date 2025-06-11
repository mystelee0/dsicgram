package egovframework;

public class PostDTO {

	String postId;
	String userId;
	String comment;
	String filesNm;
	
	public PostDTO() {
		
	}
	public PostDTO(String postId, String userId, String comment, String filesNm) {
		super();
		this.postId = postId;
		this.userId = userId;
		this.comment = comment;
		this.filesNm = filesNm;
	}

	
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getFilesNm() {
		return filesNm;
	}

	public void setFilesNm(String filesNm) {
		this.filesNm = filesNm;
	}
	
	
}

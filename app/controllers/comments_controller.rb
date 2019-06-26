class CommentsController < ApplicationController
 # #10
   before_action :require_sign_in
 
   def create
 # #11
     @post = Post.find(params[:post_id])
     comment = @post.comments.new(comment_params)
     comment.user = current_user
 
     if comment.save
       flash[:notice] = "Comment saved successfully."
 # #12
       redirect_to [@post.topic, @post]
     else
       flash[:alert] = "Comment failed to save."
 # #13
       redirect_to [@post.topic, @post]
     end
   end
 
   private
 
 # #14
   def comment_params
     params.require(:comment).permit(:body)
   end
end

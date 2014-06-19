class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id]) #parent object then the object we are dealing with
    @comment = @post.comments.build(params.require(:comment).permit(:body))
   
   if @comment.save #object we are dealing with
    flash[:notice]="Comment created"
    redirect_to post_path(@post)
  else
    render 'posts/show' #because it's in another(posts) folder
  end
end
end
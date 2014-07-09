class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id]) # parent object then the object
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save # object we are dealing with
      redirect_to :back
      flash[:notice] = 'Comment created'
    else
      @post.reload
      render 'posts/show' # because it's in another folder (posts)
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Vote Counted'
        else
          flash[:error] = 'Vote not counted'
        end
          redirect_to :back
      end
      format.js
    end
  end
end
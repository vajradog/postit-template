class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]


  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
    #Post.all maybe a bad idea for large data. Limit it. Maybe show 50 recent post etc.
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    if current_user != @post.creator
      flash[:error]= "You are not authorised to do that"
      redirect_to root_path
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:notice]="Vote Counted"
    else
      flash[:error] = "You cannot vote twice"
    end
      redirect_to :back

  end

  private
  def post_params
      params.require(:post).permit(:title, :description, :url, category_ids: [])   
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

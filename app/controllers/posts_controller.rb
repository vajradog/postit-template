class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :post_owner?, except: [:show, :index]


  def index
    @posts = Post.all.order('id DESC')
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
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  private
  def post_params
      params.require(:post).permit(:title, :description, :url, category_ids: [])   
  end

  def set_post
    @post = Post.find(params[:id])
  end

def post_owner?
  if current_user != @post.creator
      flash[:error]= "You are not authorised to do that"
      redirect_to root_path
    end
end
  
end

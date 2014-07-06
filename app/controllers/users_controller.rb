class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Welcome, #{@user.username} your account was 
                        created and you are now logged in'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Profile Updated'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def require_same_user
    if current_user != @user
      flash[:error] = 'Sorry, you are not authorized to do that'
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
  
end
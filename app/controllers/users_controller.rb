class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy, :followings, :followers]

  
  def index
    @users = User.search(params[:search]).order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(6)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを編集しました"
      redirect_to user_path
    else
      flash[:danger] = "プロフィールを編集できませんでした（原因を確認してください）"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ご利用ありがとうございました"
    redirect_to users_path
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(6)
  end
  
  def followers
    @user= User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(6)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avater, :introduce)
  end
  
end

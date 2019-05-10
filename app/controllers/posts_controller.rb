class PostsController < ApplicationController
  before_action :ensure_current_user, only: [:edit, :update]
  before_action :require_user_logged_in, only: [:new, :show, :create, :edit, :update, :destroy,]
 
  
  def index
    @posts=Post.search(params[:search]).order(created_at: :desc).page(params[:page]).per(6)
    @post=Post.new
  end
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice]="投稿しました"
      redirect_to posts_path
    else
      render new_post_path
    end
  end
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @likes_count =Like.where(post_id: @post.id).count
  end
  def new
    @post=Post.new
  end
  def edit
    @post= Post.find_by(id: params[:id])
    
  end
  def update
    @post= Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:notice] ="投稿を編集しました"
      redirect_to posts_path
    else
      flash[:notice] ="投稿を編集できませんでした"
      render edit_post_path
    end
  end
  def destroy
    @post= Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="削除しました"
    redirect_to posts_path
  end
  
  private
  def ensure_current_user
    @post= current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to posts_path
    end
  end 
  
  def post_params
    params.require(:post).permit(:content, {picture: []})
  end
end

class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @post = Post.find(params[:post_id])
    @post.like(current_user)
    flash[:success]="いいねしました"
    redirect_to @post
  end
  
  def destroy
    @post = Like.find(params[:id]).post
    @post.unlike(current_user)
    flash[:success]="いいねを解除しました"
    redirect_to @post
  end
end

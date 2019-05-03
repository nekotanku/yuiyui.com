class CommentsController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :new]
  def create
    
    @post = Post.find(params[:post_id])
    @post.comment(current_user)
    flash[:success]="いいねしました"
    redirect_to @post
  

  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end



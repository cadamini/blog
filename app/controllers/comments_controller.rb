class CommentsController < ApplicationController
  before_filter :ensure_admin!, only: [:destroy]

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      flash[:notice] = 'Comment successfully created'
    else
      flash[:error] = 'Comment creation failed'
    end
    redirect_to post_path(params[:post_id])
  end

  # creator and admin only
  def destroy
    if Comment.find(params[:id]).destroy
      flash[:notice] = 'Comment successfully deleted'
    else
      flash[:error] = 'Problem while deleting comment'
    end
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_id, :content)
  end
end

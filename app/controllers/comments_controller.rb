class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)

    if @comment.save
      @user = current_user
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.author
    @comments = @post.comments
    @index = @user.posts.order(:created_at).pluck(:id).index(@post.id) + 1
  end
end

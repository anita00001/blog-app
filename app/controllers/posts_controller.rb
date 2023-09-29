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

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to users_path(current_user, @post)
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

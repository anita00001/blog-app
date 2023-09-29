class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = Like.create(user: current_user, post: @post)

    return unless @like.save

    redirect_to @post
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end

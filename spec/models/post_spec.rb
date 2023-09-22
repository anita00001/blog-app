require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: "user1", photo: "photo1", bio: "bio1")
    @post = Post.create(title:"title1", text:"text1", author_id: @user.id)
    @comment1 = Comment.create(text:"Comment1", user_id: @user.id, post_id: @post.id)
    @comment2 = Comment.create(text:"Comment1", user_id: @user.id, post_id: @post.id)
    @comment3 = Comment.create(text:"Comment1", user_id: @user.id, post_id: @post.id)
    @comment4 = Comment.create(text:"Comment1", user_id: @user.id, post_id: @post.id)
    @comment5 = Comment.create(text:"Comment1", user_id: @user.id, post_id: @post.id)
    @comment6 = Comment.create(text:"Comment1", user_id: @user.id, post_id: @post.id)
  end

  it 'Title is required' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'Title should be less than or equal to 250 characters' do
    @post.title = 'a' * 251
    expect(@post).to_not be_valid
  end
  
  it 'Title should be less than or equal to 250 characters' do
    @post.title = 'a' * 250
    @post.comments_counter = 0
    @post.likes_counter = 0
    expect(@post).to be_valid
  end

  it 'Comments counter should be an integer' do
    @post.comments_counter = 'a'
    expect(@post).to_not be_valid
  end

  it 'Comments counter should be greater than or equal to 0' do
    @post.comments_counter = -1
    expect(@post).to_not be_valid
  end

  it 'Comments counter should be greater than or equal to 0' do
    @post.comments_counter = 1
    @post.likes_counter = 0
    expect(@post).to be_valid
  end

  it 'Likes counter should be an integer' do
    @post.likes_counter = 'a'
    expect(@post).to_not be_valid
  end

  it 'Likes counter should be greater than or equal to 0' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end

  it 'Likes counter should be greater than or equal to 0' do
    @post.likes_counter = 1
    @post.comments_counter = 0
    expect(@post).to be_valid
  end

  it 'Most recent comments should return 5 comments' do
    @recent_comments= @post.comments.order(created_at: :desc).limit(5)
    
    @recent_comments.each do |comments|
      expect(@recent_comments.length).to eq(5)
    end
  end
end
require 'rails_helper'
require 'capybara'

RSpec.feature 'Posts Show Page', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Kate',
      photo: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
      bio: 'Teacher from France'
    )
    @user2 = User.create(
      name: 'Tom',
      photo: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
      bio: 'Student from Poland'
    )
    @post1 = Post.create(
      author: @user1,
      title: 'First Post',
      text: 'This is my first post'
    )
    @comment1 = Comment.create(
      post: @post1,
      user: @user2,
      text: 'This is my first comment'
    )
    @comment2 = Comment.create(
      post: @post1,
      user: @user2,
      text: 'This is my second comment'
    )
    @comment3 = Comment.create(
      post: @post1,
      user: @user2,
      text: 'This is my third comment'
    )
    @comment4 = Comment.create(
      post: @post1,
      user: @user2,
      text: 'This is my fourth comment'
    )
    @comment5 = Comment.create(
      post: @post1,
      user: @user2,
      text: 'This is my fifth comment'
    )
    @comment6 = Comment.create(
      post: @post1,
      user: @user2,
      text: 'This is my sixth comment'
    )

    Like.new(user: @user1, post: @post1)

    visit user_post_path(@user1, @post1)
  end

  scenario 'I can see a post/s title' do
    expect(page).to have_content(@post1.title)
  end

  scenario 'I can see who wrote the post' do
    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_content(@post1.comments.count)
  end

  scenario 'I can see how many likes a post has' do
    expect(page).to have_content(@post1.likes.count)
  end

  scenario 'I can see the post body' do
    expect(page).to have_content(@post1.text)
  end

  scenario 'I can see the username of each commentor' do
    comments = [@comment1, @comment2, @comment3, @comment4, @comment5, @comment6]
    comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  scenario 'I can see the comment each commentor left' do
    comments = [@comment1, @comment2, @comment3, @comment4, @comment5, @comment6]
    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end

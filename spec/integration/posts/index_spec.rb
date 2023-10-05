require 'rails_helper'
require 'capybara'

RSpec.feature 'Posts Index Page', type: :feature do
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

    visit user_posts_path(@user1)
  end

  scenario 'I can see the user/s profile picture' do
    expect(page).to have_css("img[src*='#{@user1.photo}']")
  end

  scenario 'I can see the user/s username' do
    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see the number of posts each user has written' do
    expect(page).to have_content(@user1.posts.count)
  end

  scenario 'I can see a post/s title' do
    expect(page).to have_content(@post1.title)
  end

  scenario 'I can see some of the post/s body' do
    expect(page).to have_content(@post1.text)
  end

  scenario 'I can see the five recent comments on a post' do
    most_recent_comments = @post1.comments.order(created_at: :desc).limit(5)
    most_recent_comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_content(@post1.comments.count)
  end

  scenario 'I can see how many likes a post has' do
    expect(page).to have_content(@post1.likes.count)
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_link('Pagination')
  end

  scenario 'When I click on a post, it redirects me to that post/s show page' do
    click_link @post1.title
    expect(page).to have_current_path(user_post_path(@user1, @post1))
  end
end

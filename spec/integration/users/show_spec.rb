require 'rails_helper'
require 'capybara'

RSpec.feature 'User Show Page', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Tom',
      photo: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
      bio: 'Teacher from Mexico'
    )
    @post1 = Post.create(
      author: @user1,
      title: 'First Post',
      text: 'This is my first post'
    ),
             @post2 = Post.create(
               author: @user1,
               title: 'Second Post',
               text: 'This is my second post'
             ),
             @post3 = Post.create(
               author: @user1,
               title: 'Third Post',
               text: 'This is my third post'
             ),
             @post4 = Post.create(
               author: @user1,
               title: 'Fourth Post',
               text: 'This is my fourth post'
             )

    visit user_path(@user1)
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

  scenario 'I can see the user/s bio' do
    expect(page).to have_content(@user1.bio)
  end

  scenario 'I can see the user/s first 3 posts' do
    most_recent_posts = @user1.posts.order(created_at: :desc).limit(3)
    most_recent_posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  scenario 'I can see a button that lets me view all of a user/s posts' do
    expect(page).to have_content('See All Posts')
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    click_on @post2.text
    expect(page).to have_current_path(user_post_path(@user1, @post2))
  end

  scenario 'When I click to see all posts, it redirects me to the user/s post/s index page' do
    click_link 'See All Posts'
    expect(current_path).to eq(user_posts_path(@user1))
  end
end

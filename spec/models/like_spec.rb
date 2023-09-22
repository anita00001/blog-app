require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: "user1", photo: "photo1", bio: "bio1")
    @post = Post.create(title: "title1", text: "text1", author_id: @user.id)
  end

  it 'should update like counter by 1' do
    expect(@post.likes_counter).to eq(0)
    Like.create(user_id: @user.id, post_id: @post.id)
    
    @post.reload
    
    expect(@post.likes_counter).to eq(1)
  end
end
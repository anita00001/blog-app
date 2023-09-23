require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'user1', photo: 'photo1', bio: 'bio1')
    @post = Post.create(title: 'title1', text: 'text1', author_id: @user.id)
  end

  it 'should update comment counter by 1' do
    expect(@post.comments_counter).to eq(0)
    Comment.create(text: 'Comment1', user_id: @user.id, post_id: @post.id)

    @post.reload

    expect(@post.comments_counter).to eq(1)
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe') }

  before { subject.save }

  it 'Name is required' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Post counter should be integer' do
    subject.post_counter = 'abc'
    expect(subject).to_not be_valid
  end

  it 'Post counter should be greater than or equal to 0' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Post counter should be greater than or equal to 0' do
    subject.post_counter = 0
    expect(subject).to be_valid
  end

  it 'Most recent posts should return 3 posts' do
    4.times do |i|
      subject.posts.create(title: "Post #{i + 1}")
    end
    expect(subject.most_recent_posts.length).to eq(3)
  end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  # subject { Post.new(title: 'My first post', author: User.new(name: 'John Doe'), comments_counter: 0, likes_counter: 0) }
  subject { Post.new(title: 'My first post', author: User.new(name: 'John Doe')) }

  before { subject.save }

  it 'Title is required' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Title should be less than or equal to 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end
  
  it 'Title should be less than or equal to 250 characters' do
    subject.title = 'a' * 250
    subject.comments_counter = 0
    subject.likes_counter = 0
    expect(subject).to be_valid
  end

  it 'Comments counter should be an integer' do
    subject.comments_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'Comments counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Comments counter should be greater than or equal to 0' do
    subject.comments_counter = 1
    subject.likes_counter = 0
    expect(subject).to be_valid
  end

  it 'Likes counter should be an integer' do
    subject.likes_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'Likes counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Likes counter should be greater than or equal to 0' do
    subject.likes_counter = 1
    subject.comments_counter = 0
    expect(subject).to be_valid
  end
end
# spec/controllers/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'returns a 200 OK status' do
      user = User.create(name: 'Test User')
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      user = User.create(name: 'Test User')
      get "/users/#{user.id}/posts"
      expect(response).to render_template('index')
    end

    it 'renders correct placeholder text' do
      user = User.create(name: 'Test User')
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Welcome to the Post page!')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      user = User.create(name: 'Test User')
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = User.create(name: 'Test User')
      post = user.posts.create(title: 'Test Post', text: 'Test Content')
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('show')
    end

    it 'renders correct placeholder text' do
      user = User.create(name: 'Test User')
      post = user.posts.create(title: 'Test Post', text: 'Test Content')
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Here is a list of posts for a given user.')
    end
  end
end

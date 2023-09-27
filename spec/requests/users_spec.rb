require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'returns a 200 OK status' do
      User.create(name: 'Test User')
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      User.create(name: 'Test User')
      get users_path
      expect(response).to render_template('index')
    end

    it 'renders correct placeholder text' do
      User.create(name: 'Test User')
      get users_path
      expect(response.body).to include('Welcome to my Blog!')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      user = User.create(name: 'Test User')
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = User.create(name: 'Test User')
      get user_path(user)
      expect(response).to render_template('show')
    end

    it 'renders correct placeholder text' do
      user = User.create(name: 'Test User')
      get user_path(user)
      expect(response.body).to include('Here is a list of users!')
    end
  end
end

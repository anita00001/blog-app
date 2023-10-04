require 'rails_helper'
require 'capybara'

RSpec.feature 'User Index Page', type: :feature do
  let(:users) do
    [
      User.create(
        name: 'Peter',
        photo: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
        bio: 'Teacher from Mexico'
      ),
      User.create(
        name: 'Lilly',
        photo: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
        bio: 'Teacher from Poland'
      ),
      User.create(
        name: 'Kate',
        photo: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
        bio: 'Teacher from France'
      )
    ]
  end

  before do
    users
    visit users_path
  end

  scenario 'I can see the username of all other users' do
    users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  scenario 'I can see the profile picture for each user' do
    users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  scenario 'I can see the number of posts each user has written' do
    users.each do |user|
      expect(page).to have_content(user.posts.count)
    end
  end

  scenario 'When I click on a user, I am redirected to that user/s show page' do
    users.each do |user|
      click_on user.name
      expect(current_path).to eq(user_path(user))
      visit users_path # redirects to the users index page
    end
  end
end

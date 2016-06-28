require 'rails_helper'

RSpec.describe "UserSignups", type: :request do
  describe "a valid registration process" do
    it "creates a new user" do
      visit '/users/new'

      fill_in 'Email', with: 'bob.schmidt@server.com'
      fill_in 'Password', with: '1234'
      fill_in 'Password confirmation', with: '1234'
      fill_in 'Name', with: 'Bob Schmidt'

      click_on 'Register'

      expect(page).to have_content('bob.schmidt@server.com')
      expect(page).to have_content('Bob Schmidt')
    end

    it "doesn't create an invalid user" do
      visit '/users/new'

      fill_in 'Email', with: 'bob.schmidt@server.com'
      fill_in 'Password', with: '1234'
      fill_in 'Password confirmation', with: '123'
      fill_in 'Name', with: 'Bob Schmidt'

      click_on 'Register'

      expect(page).to have_field('Email')
      expect(page).to_not have_content('bob.schmidt@server.com')
    end
  end
end

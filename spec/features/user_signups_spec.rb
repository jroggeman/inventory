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
  end
end

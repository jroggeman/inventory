require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET /users/new" do
    it "should assign @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "should render the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
end

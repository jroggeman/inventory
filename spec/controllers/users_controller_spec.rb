require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET new" do
    it "should assign @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "should render the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET show" do
    it "should assign @user" do
      user = create :user
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "should render the show template" do
      user = create :user
      get :show, id: user
      expect(response).to render_template("show")
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "should create a new user" do
        # user = build :user
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by 1
      end

      it "should redirect to the user" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to User.last
      end
    end

    context "with invalid attributes" do
      it "should not create a new user" do
        expect {
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it "should render the new template" do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template("new")
      end
    end
  end
end

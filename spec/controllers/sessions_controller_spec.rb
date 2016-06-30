require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it "should include authentication concern" do
    expect(SessionsController.ancestors.include? Authentication).to be true
  end

  describe "GET new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "with valid login" do
      before :each do
        @user = create :user
      end

      it "should redirect to boxes#index" do
        post :create, session: attributes_for(:user)
        expect(response).to redirect_to boxes_path
      end

      it "should store the user ID in the session" do
        post :create, session: attributes_for(:user)
        expect(session[:id]).to eq(@user.id)
      end
    end

    context "with invalid login" do
      before :each do
        @user = create :user
      end

      it "should set session to nil" do
        post :create, session: attributes_for(:user, password: nil)
        expect(session[:id]).to eq(nil)
      end

      it "should render the new template" do
        post :create, session: attributes_for(:user, password: nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET destroy" do
    before :each do
      create :user
      session[:id] = User.last.id
    end

    it "should clear session[:id]" do
      get :destroy
      expect(session[:id]).to eq(nil)
    end

    it "should redirect to login" do
      get :destroy
      expect(response).to render_template("new")
    end
  end
end

require 'rails_helper'

RSpec.describe BoxesController, type: :controller do
  before :each do
    @user = create :user
    login_as @user
  end

  describe "GET index" do
    it "should assign boxes" do
      box = create :box, user: @user

      get :index
      expect(assigns(:boxes)).to eq([box])
    end

    it "should only display your boxes" do
      other_user = create :user, email: "other@server.com"

      box = create :box, user: @user
      create :box, user: other_user

      get :index
      expect(assigns(:boxes)).to eq([box])
    end
  end
end

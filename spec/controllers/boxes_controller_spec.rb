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

  describe "GET new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "should assign @box" do
      get :new
      expect(assigns(:box)).to_not be nil
    end
  end
end

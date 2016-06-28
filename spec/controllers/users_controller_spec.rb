require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it "should include authentication concern" do
    expect(UsersController.ancestors.include? Authentication).to be true
  end

  describe "GET show" do
    before :each do
      @user = create :user
      login_as @user
    end

    it "should assign @user" do
      get :show, id: @user
      expect(assigns(:user)).to eq(@user)
    end

    it "should render the show template" do
      get :show, id: @user
      expect(response).to render_template("show")
    end
  end

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

  describe "POST create" do
    it "should assign user" do
      post :create, user: attributes_for(:user)
      expect(assigns(:user)).to eq(User.last)
    end

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

  describe "GET edit" do
    before :each do
      @user = create(:user)
      login_as @user
    end

    it "should render the edit template" do
      get :edit, id: @user
      expect(response).to render_template("edit")
    end

    it "should assign @user" do
      get :edit, id: @user
      expect(assigns(:user)).to eq(@user)
    end
  end

  describe "PATCH update" do
    before :each do
      @user = create(:user)
      login_as @user
    end

    context "with valid parameters" do
      it "should update the parameters" do
        put :update, id: @user, user: attributes_for(:user, name: "Jim")
        expect(User.last.name).to eq("Jim")
      end

      it "should assign the right user" do
        put :update, id: @user, user: attributes_for(:user, name: "Jim")
        expect(assigns(:user)).to eq(@user)
      end

      it "should redirect to the show page" do
        put :update, id: @user, user: attributes_for(:user, name: "Jim")
        expect(response).to redirect_to @user
      end
    end

    context "with invalid parameters" do
      it "should assign the right user" do
        put :update, id: @user, user: attributes_for(:user, name: nil)
        expect(assigns(:user)).to eq(@user)
      end

      it "should not update the user" do
        put :update, id: @user, user: attributes_for(:user, name: nil)
        @user.reload
        expect(@user.name).to_not eq(nil)
      end

      it "should render the edit template" do
        put :update, id: @user, user: attributes_for(:user, name: nil)
        expect(response).to render_template "edit"
      end
    end
  end

  describe "DElETE destroy" do
    before :each do
      @user = create :user
      login_as @user
    end

    it "should assign the right user" do
      delete :destroy, id: @user
      expect(assigns(:user)).to eq(@user)
    end

    it "should delete the user" do
      expect {
        delete :destroy, id: @user
      }.to change(User, :count).by(-1)
    end

    it "should redirect to new" do
      delete :destroy, id: @user
      expect(response).to redirect_to new_user_path
    end
  end
end

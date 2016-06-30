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

  describe "GET show" do
    it "should assign the expected box" do
      box = create :box, user: @user

      get :show, id: box
      expect(assigns(:box)).to eq(Box.last)
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

  describe "POST create" do
    context "with valid parameters" do
      it "should create a new box" do
        expect {
          post :create, box: attributes_for(:box, user: @user)
        }.to change(Box, :count).by(1)
      end

      it "should redirect to the box" do
        post :create, box: attributes_for(:box, user: @user)
        expect(response).to redirect_to Box.last
      end
    end

    context "with invalid parameters" do
      it "should not create a new box" do
        expect {
          post :create, box: attributes_for(:box, user: @user, name: nil)
        }.to_not change(Box, :count)
      end

      it "should render the new template" do
        post :create, box: attributes_for(:box, user: @user, name: nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET edit" do
    before :each do
      @box = create :box, user: @user
    end

    it "should assign @box" do
      get :edit, id: @box
      expect(assigns(:box)).to eq(Box.last)
    end

    it "should not assign a box that isn't yours" do
      other_user = create :user, email: 'other@server.com'
      other_box = create :box, user: other_user

      get :edit, id: other_box
      expect(response).to redirect_to @user
    end
  end

  describe "PATCH update" do
    before :each do
      @box = create :box, user: @user
    end

    context "with valid parameters" do
      it "should update the box" do
        patch :update, id: @box, box: attributes_for(:box, name: 'Updated')
        expect(Box.last.name).to eq('Updated')
      end

      it "should assign @box" do
        patch :update, id: @box, box: attributes_for(:box, name: 'Updated')
        expect(assigns(:box)).to eq(Box.last)
      end

      it "should redirect to show" do
        patch :update, id: @box, box: attributes_for(:box, name: 'Updated')
        expect(response).to redirect_to(@box)
      end
    end

    context "with invalid parameters" do
      it "should not update the box" do
        patch :update, id: @box, box: attributes_for(:box, name: nil)
        @box.reload
        expect(@box.name).to_not be nil
      end

      it "should render edit" do
        patch :update, id: @box, box: attributes_for(:box, name: nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @box = create :box, user: @user
    end

    it "should destroy the item" do
      expect {
        delete :destroy, id: @box
      }.to change(Box, :count).by(-1)
    end

    it "should redirect to box index" do
      delete :destroy, id: @box
      expect(response).to redirect_to(boxes_path)
    end
  end
end

require 'rails_helper'

RSpec.describe Authentication, type: :controller do
  controller(ApplicationController) do
    include Authentication

    def generic_action
      render nothing: true
    end
  end

  before {
    routes.draw {
      get 'new' => 'anonymous#generic_action'
    }
  }

  describe 'generic_action' do
    it "should redirect when not logged in" do
      get :generic_action
      expect(response).to redirect_to login_url
    end

    it "should allow when logged in" do
      user = create :user
      login_as user
      get :generic_action
      expect(response).to_not redirect_to login_url
    end
  end
end

module Authentication
  extend ActiveSupport::Concern

  included do
    # Check for login for each route
    before_action :require_authentication
    helper_method :current_user
  end

  module ClassMethods
    def skip_authentication(options = {})
      skip_before_action :require_authentication, options.slice(:only, :except)
    end
  end

  private

  def current_user
    @current_user ||= User.find_by_id(session[:id]) if session[:id]
  end

  def login_as(user)
    session[:id] = user.id
  end

  def require_authentication
    unless current_user
      session[:return_to] = url_for(params)
      redirect_to login_url
    end
  end
end

class SessionsController < ApplicationController
  skip_authentication only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: user_params[:email])

    if user && user.authenticate(user_params[:password])
      login_as user

      if session.key?(:return_to)
        url = session[:return_to]
        session[:return_to] = nil
        redirect_to url
      else
        redirect_to boxes_path
      end
    else
      render 'new'
    end
  end

  def destroy
    session[:id] = nil
    render 'new'
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end
end

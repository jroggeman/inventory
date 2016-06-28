class SessionsController < ApplicationController
  skip_authentication only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: user_params[:email])

    if user && user.authenticate(user_params[:password])
      login_as user
      redirect_to user
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

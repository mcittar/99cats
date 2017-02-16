class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login!(@user)
      redirect_to cats_url
    else
      flash[:errors] = ["Invalid Credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
    end

    session[:session_token] = nil
    redirect_to new_session_url
  end
end

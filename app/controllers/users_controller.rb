class UsersController < ApplicationController

  before_action :ensure_not_logged_in, only: [:new, :create]


  def ensure_not_logged_in
    redirect_to cats_url if current_user
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end

  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

class UsersController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
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

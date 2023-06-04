class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
  end
end

  private
  def user_params
    params.require(:user).permit(:name, :email, :icon, :password, :password_confirmation)
  end
end
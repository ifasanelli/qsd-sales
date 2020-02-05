class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update]
  def index
    @users = User.all
  end

  def edit; end

  def update
    @user.update(user_params)
    redirect_to users_path
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
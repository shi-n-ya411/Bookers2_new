class UsersController < ApplicationController
  before_action :authenticate_user!  # ログインしたユーザーのみアクセスできるようにする

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Your account has been updated successfully.'
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end

end
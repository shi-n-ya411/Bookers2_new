class UsersController < ApplicationController
  before_action :authenticate_user!  # ログインしたユーザーのみアクセスできるようにする

  def show
    @user = User.find(params[:id])
    @books = current_user.books # ログイン中のユーザーの Book を取得
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を更新しました'
    else
      render :edit
    end
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

end
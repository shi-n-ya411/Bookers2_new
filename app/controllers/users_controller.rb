class UsersController < ApplicationController
  before_action :authenticate_user!  # ログインしたユーザーのみアクセスできるようにする

  def show
    @user = User.find(params[:id])
    @books = current_user.books # ログイン中のユーザーの Book を取得
  end

  def edit
  end

  def index
    @users = User.all  
  end

end
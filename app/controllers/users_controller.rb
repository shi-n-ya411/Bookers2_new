class UsersController < ApplicationController
  before_action :authenticate_user!  # ログインしたユーザーのみアクセスできるようにする

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end

  def index
    @users = User.all  
  end

end
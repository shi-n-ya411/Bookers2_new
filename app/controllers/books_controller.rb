class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def index
    @books = Book.all
    @user = current_user
    # @book = Book.find(params[:id]
  end

  def show
    @book = Book.find(params[:id]) # 特定のBookオブジェクトを取得
    @user = @book.user # Bookオブジェクトに関連するUserを取得
    @books = Book.all  # 全てのBookオブジェクトを取得
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      # 更新が成功した場合
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      # 更新が失敗した場合
      flash.now[:alert] = 'Failed to update the book.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book was successfully deleted."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :caption)
  end

end
class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
 
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "New book has been successfully created!"
      redirect_to book_path(@book)
    else
      flash[:alert] = @book.errors.full_messages.join(", ")
      redirect_to books_path
    end
  end

  def index
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user

  end

  def edit
    # book = Book.find(params[:id])
    # unless book.id == current_user.id
    #   redirect_to books_path
    # end
  
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
    
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      render :edit
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

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
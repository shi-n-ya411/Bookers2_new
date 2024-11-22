class BooksController < ApplicationController



  def new
    @book = Book.new
  end

  def create
    # @book = Book.new(book_params)
    # @book.user_id = current_user.id
    # @book.save
    # redirect_to books_path
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "New book has been successfully created!" 
      redirect_to books_path
    else
      flash[:alert] = "There was an error creating the book. Please try again." 
      render :new
    end
  end

  def index
    @books = Book.all
    @user = current_user
    # @book = Book.find(params[:id])
  end

  def show
    # @book = Book.find(params[:id])
    # @user = @book.user
    # # @books = current_user.books
    # @user = User.find(params[:id])  
    # @books = @user.books           

    @book = Book.find(params[:id]) 
    @user = @book.user             
    # @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
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
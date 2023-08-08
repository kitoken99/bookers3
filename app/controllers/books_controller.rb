class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.image.attach(io: File.open('app/assets/images/no_image.jpg'), filename: 'no_image.jpg', content_type: 'image/jpeg')
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end
  
  def show 
    @thisBook = Book.find(params[:id])
    @book = Book.new
    @user = User.find(@thisBook.user_id)
  end
  def edit
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end
  private

  def book_params
    params.require(:book).permit(:title, :body, :image, :user_id)
  end
end
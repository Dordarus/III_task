class BooksController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show] 
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :check_reader, only: [:new, :create]
  before_action :book_owner?, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
  end


  def show
  end

  def new
    @book = Book.new
  end


  def edit
  end

 
  def create
    @book = current_user.books.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, flash: {success: 'Book was successfully created.'} }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, flash: {success: 'Book was successfully updated.'}}
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), flash: {danger: 'Book was successfully deleted.'} }
      format.json { head :no_content }
    end
  end

  private

  def book_owner?
    unless set_book.owner?(current_user) 
      then redirect_to books_path, 
      flash: {danger: "You aren't the owner of the book. You can't make any changes"} 
    end
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
     params.require(:book).permit(:title, :genre, :year, :plot)
  end
end

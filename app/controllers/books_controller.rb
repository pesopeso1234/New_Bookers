class BooksController < ApplicationController

  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update]

  def index
    @user = User.find_by(id: current_user.id)
    @book_add = Book.new
    @books = Book.all
  end

  def new
  end

  def create
    @book_add = Book.new(book_params)
    @book_add.user_id = current_user.id
    @book_add.save
    if @book_add.errors.any?
      @user = User.find_by(id: current_user.id)
      @books = Book.all
      render 'index'
    else
      redirect_to book_path(@book_add.id), notice: "Book was successfully created."
    end
  end

  def show
    @book_add = Book.new
    @select_book = Book.find(params[:id])
    @user = User.find_by(id: @select_book.user_id)

  end

  def edit
    @edit_book = Book.find(params[:id])
    if @edit_book.user_id == current_user.id
      @edit_book = Book.find(params[:id])
    else
      redirect_to books_path
    end
  end

  def update
    @edit_book = Book.find(params[:id])
    @edit_book.update(book_params)
    if @edit_book.errors.any?
      render 'edit'
    else
      redirect_to book_path(@edit_book.id), notice: "Book was successfully updated."
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, method: :get, notice: "Book was successfully destroyed."
  end

  private

  def book_params
      params.require(:book).permit(:title, :opinion, :user_id)
  end

end

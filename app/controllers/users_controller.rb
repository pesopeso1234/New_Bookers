class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :show, :edit, :update]
  def home
  end

  def about
  end

  def index
    @users = User.all
    @user = User.find_by(id: current_user.id)
    @book_add = Book.new
  end

  def show
	  @user = User.find(params[:id])
    @book_add = Book.new
    @books = Book.new
    @books.user_id = @user.id
    @books = Book.where(user: @books.user_id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.errors.any?
     render 'edit'
    else
     redirect_to user_path(@user.id), notice: "User was successfully updated."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image,:email)
  end


end

class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  # 下記２行はrenderよう
    @user = current_user
    @books = Book.all
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
  # エラーメッセージ用ダミー
    @book = Book.first
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_update_params)
      flash[:success] = "You have edited book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end

  def book_params
    params.permit(:title, :body)
  end

  def book_update_params
    params.require(:book).permit(:title, :body)
  end

end
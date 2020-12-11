class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have edited profile successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

private

def correct_user
  user = User.find(params[:id])
  if current_user != user
    redirect_to user_path(current_user.id)
  end
end

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end

end
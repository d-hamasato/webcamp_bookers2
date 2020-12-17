class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(book_id: params[:book_id])
    favorite.save
    redirect_to book_path(favorite.book_id)

  end

  def destroy
  end
end
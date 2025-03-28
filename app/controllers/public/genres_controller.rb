class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = @genre.items.where(is_active: true).page(params[:page]).per(8)
    @all_items = Item.where(genre_id: @genre.id, is_active: true)
  end
end

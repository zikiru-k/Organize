class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer

  def create
    @item = Item.find(params[:item_id])
    favorite = current_customer.favorites.new(item_id: @item.id)
    favorite.save
    render 'favorite_btn'
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_customer.favorites.find_by(item_id: @item.id)
    favorite.destroy
    render 'favorite_btn'
  end

  private

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to top_path, notice: "新規登録をしてください。"
   end
  end
end

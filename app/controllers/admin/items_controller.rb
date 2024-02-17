class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:index, :search]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      item.update_tags(params[:item][:tag])
      flash[:notice] = "商品登録情報を更新しました。"
      redirect_to group_item_path(params[:group_id], item)
    else
      flash[:notice] = "商品登録情報を更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    Item.find(params[:id]).destroy()
    redirect_to group_items_path(params[:group_id])
  end

  def search
    @results = @q.result
  end

  private

  def item_params
    params.require(:item).permit(:name, :code, :capacity, :site)
  end

  def set_q
    @q = Item.ransack(params[:q])
  end
end

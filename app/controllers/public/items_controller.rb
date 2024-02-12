class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def ajax_show
    @item = Item.find(params[:id])
    render layout:false
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      item.save_tags(params[:item][:tag])
      redirect_to group_item_path(params[:group_id], item), notice: "商品登録が出来ました"
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :code, :capacity, :site)
  end
end

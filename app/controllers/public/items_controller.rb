class Public::ItemsController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @items = Item.all
    # @items = Item.where(group_id: params[:group_id])
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

  def edit
    @item = Item.find(params[:id])
    # @tag = @item.tags.pluck(:name).join(' ')
  end

  # def update
  #   item = Item.find_by(id: params[:id])
  #   tag = params[:item][:tag].split(' ')
  #   if item.update(tag: tag)
  #     flash[:notice] = 'タグを追加できました'
  #   else
  #     flash[:notice] = 'タグの追加に失敗しました'
  #   end
  #   redirect_to request.referer
  # end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      item.save_tags(params[:item][:tag])
      redirect_to group_items_path(params[:group_id])
    else
      render :edit
    end
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

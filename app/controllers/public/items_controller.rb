class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :set_q, only: [:index, :favorite_index, :search]
  before_action :ensure_guest_customer

  def index
    @items = Item.where(group_id: params[:group_id]).page(params[:page])
  end

  def favorite_index
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:item_id)
    @items = Item.where(id: favorites).page(params[:page])
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
      flash[:notice] = "商品登録が出来ました"
      redirect_to group_item_path(params[:group_id], item)
    else
      flash.now[:alert] = "商品登録が出来ませんでした"
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
      flash[:notice] = "変更内容を保存しました。"
      redirect_to group_items_path(params[:group_id])
    else
      flash.now[:alert] = "変更内容を保存できませんでした。"
      render :edit
    end
  end

  def search
    @results = @q.result
  end

  private

  def item_params
    params.require(:item).permit(:name, :code, :capacity, :site, :group_id).merge(group_id: params[:group_id])
  end

  def set_q
    @q = Item.ransack(params[:q])
  end
end

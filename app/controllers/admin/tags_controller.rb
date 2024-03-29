class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    items = Item.where(group_id: params[:group_id])
    tags = []
    items.each do |item|
      tags += item.tags
    end
    @tags = Kaminari.paginate_array(tags).page(params[:page]).per(24)
  end

  def show
    @tag = Tag.find(params[:id])
    @items = @tag.items.where(group_id: params[:group_id]).page(params[:page])
  end

  def destroy
    Tag.find(params[:id]).destroy()
    flash[:alert] = "タグを削除しました。"
    redirect_to request.referer
  end
end

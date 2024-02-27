class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    items = Item.where(group_id: params[:group_id])
    @tags = []
    items.each do |item|
      @tags += item.tags
    end
  end

  def destroy
    Tag.find(params[:id]).destroy()
    flash[:alert] = "タグを削除しました。"
    redirect_to request.referer
  end
end

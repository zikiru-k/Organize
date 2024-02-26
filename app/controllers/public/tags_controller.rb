class Public::TagsController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer
  before_action :get_latest_article

  def index
    items = Item.where(group_id: params[:group_id])
    @tags = []
    items.each do |item|
      @tags += item.tags
    end
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to request.referer
  end
end

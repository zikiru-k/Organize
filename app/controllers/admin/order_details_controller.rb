class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = OrderDetail.includes(:order).where(orders: { group_id: params[:group_id] }).ransack(params[:q])
    @order_details = @q.result(distinct: true)
  end

  def update
    order_detail = OrderDetail.find(params[:id])

    if order_detail.update(stats_params)
      flash[:notice] = "ステータスを更新しました。"
      redirect_to admin_group_order_details_path(params[:group_id])
    else
      flash.now[:alert] = "ステータスの更新に失敗しました。"
      render :index
    end
  end

  private

  def stats_params
    params.require(:order_detail).permit(:stock_stats)
  end
end

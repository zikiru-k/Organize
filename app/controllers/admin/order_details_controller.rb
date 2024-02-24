class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @order_details = OrderDetail.includes(:order).where(orders: { group_id: params[:group_id] })
  end

  def update
    order_detail = OrderDetail.find(params[:id])

    if order_detail.update(stats_params)
      redirect_to admin_group_order_details_path(params[:group_id]), notice: "ステータスを更新しました。"
    else
      render :index, notice: "ステータスの更新に失敗しました。"
    end
  end

  private

  def stats_params
    params.require(:order_detail).permit(:stock_stats)
  end
end

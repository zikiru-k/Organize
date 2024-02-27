class Public::OrderDetailsController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer

  def index
    @q = OrderDetail.includes(:order).where(orders: { group_id: params[:group_id] }).ransack(params[:q])
    @order_details = @q.result(distinct: true)
  end

  def update
    order_detail = OrderDetail.find(params[:id])

    if order_detail.update(stats_params)
      redirect_to group_order_details_path(params[:group_id]), notice: "ステータスを更新しました。"
    else
      render :index, notice: "ステータスの更新に失敗しました。"
    end
  end

  private

  def stats_params
    params.require(:order_detail).permit(:stock_stats)
  end
end
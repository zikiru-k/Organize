class Public::OrderDetailsController < ApplicationController
  def index
    @order_details = OrderDetail.includes(:order).where(orders: { group_id: params[:group_id] })
  end

  def update
    order_detail = OrderDetail.find(params[:id])
    order = order_detail.order
    rder_detail.update(stats_params)

    if order.ordered
      order_details.update(stock_stats: 1)
    elsif order.delivered
      order_details.update(stock_stats: 2)
    elsif order.cancel
      order_details.update(stock_stats: 3)
    end
    redirect_to group_order_details_path(params[:group_id]), notice: "ステータスを更新しました。"
    # render :index, notice: "ステータスの更新に失敗しました。"
  end

  private

  def stats_params
    params.require(:order_detail).permit(:stock_stats)
  end
end

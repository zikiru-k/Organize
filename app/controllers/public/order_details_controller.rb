class Public::OrderDetailsController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer

  def index
    @order_details = OrderDetail.includes(:order).where(orders: { group_id: params[:group_id] })
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

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to top_path, notice: "新規登録をしてください。"
   end
  end
end

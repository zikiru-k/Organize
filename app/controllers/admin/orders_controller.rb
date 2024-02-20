class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.where(group_id: params[:group_id])
  end

  def show
    @order = Order.find(params[:id])
    @comment = Comment.new
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      redirect_to admin_group_orders_path(params[:group_id]), notice: "ステータスを更新しました。"
    else
      render :edit, notice: "ステータスの更新に失敗しました。"
    end
  end

  private

  def order_params
    params.require(:order).permit(:stats)
  end
end

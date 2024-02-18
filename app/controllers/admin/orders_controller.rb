class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      redirect_to admin_group_order_path(params[:group_id], order)
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:stats)
  end
end

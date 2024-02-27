class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    order = Order.find(params[:order_id])
    Comment.find(params[:id]).destroy
    redirect_to admin_group_order_path(order.group_id, order)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

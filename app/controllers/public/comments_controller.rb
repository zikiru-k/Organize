class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer
  before_action :get_latest_article

  def create
    order = Order.find(params[:order_id])
    comment = current_customer.comments.new(comment_params)
    comment.order_id = order.id
    comment.save
    redirect_to group_order_path(order.group_id, order)
  end

  def destroy
    order = Order.find(params[:order_id])
    Comment.find(params[:id]).destroy
    redirect_to group_order_path(order.group_id, order)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

class Public::CommentsController < ApplicationController

  def create
    order = Order.find(params[:order_id])
    comment = current_user.order_comments.new(comment_params)
    comment.order_id = order.id
    comment.save
    # redirect_to order_path(order)
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

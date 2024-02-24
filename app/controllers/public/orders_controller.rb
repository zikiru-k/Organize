class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer

  def index
    @orders = Order.where(group_id: params[:group_id])
  end

  def show
    @order = Order.find(params[:id])
    @comment = Comment.new
  end

  def new
    @order = Order.new
  end

  def create
    ActiveRecord::Base.transaction do
      @order = Order.new(order_params)

      if @order.save
        # 新規商品があればitemに新規登録される
        # index:配列の番号が入る
        params[:new_items][:name].each_with_index do |name, index|
          next if name.blank?
          item = Item.find_or_create_by(name: name) do |item|
            item.code = params[:new_items][:code][index]
            item.capacity = params[:new_items][:capacity][index]
            item.site = params[:new_items][:site][index]
            item.group_id = params[:group_id]
          end

          @order.order_details.create(item_id: item.id, amount:  params[:new_items][:amount][index])
        end

        @order.comments.create(customer_id: current_customer.id, content: params[:comment]) if params[:comment].present?

        redirect_to group_orders_path
      else
        render :new
      end
    end
  end

  def update
    order = Order.find(params[:id])
    order_details = order.order_details

    if order.update(stats_params)
      if order.ordered?
        order_details.update_all(stock_stats: 1)
      elsif order.delivered?
        order_details.update_all(stock_stats: 2)
      elsif order.cancel?
        order_details.update_all(stock_stats: 3)
      end
      redirect_to group_orders_path(params[:group_id]), notice: "ステータスを更新しました。"
    else
      render :inde, notice: "ステータスの更新に失敗しました。"
    end
  end

  private

  def order_params
    # orderかnew_itemsがなにもない場合、バリデーションエラーとする。
    return if params[:order].blank? || params[:new_items].blank?

    # モデル名_attributesが子のモデルに保存する要素
    #   :id, :_destroyをつけることで、編集と削除が可能になる
    params.require(:order).permit(order_details_attributes: [:id, :item_id, :amount, :_destroy])
          .merge(group_id: params[:group_id], customer_id: current_customer.id)
  end

  def stats_params
    params.require(:order).permit(:stats)
  end

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to top_path, notice: "新規登録をしてください。"
   end
  end
end
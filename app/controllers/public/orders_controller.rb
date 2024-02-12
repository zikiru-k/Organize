class Public::OrdersController < ApplicationController

  def index
    @orders = Order.all
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
          end
          @order.order_details.create(item_id: item.id, amount:  params[:new_items][:amount][index])
        end

        @order.comments.create(customer_id: current_customer.id, content: params[:comment])

        redirect_to group_orders_path
      else
        render :new
      end
    end
  end

  def show
    @order = Order.find(params[:id])
    @comment = Comment.new
  end

  private

  def order_params
    # orderかnew_itemsがなにもない場合、バリデーションエラーとする。
    return if params[:order].blank? || params[:new_items].blank?

    # モデル名_attributesが子のモデルに保存する要素
    #   :id, :_destroyをつけることで、編集と削除が可能になる
    params.require(:order).permit(order_details_attributes: [:id, :item_id, :amount, :_destroy]).merge(group_id: params[:group_id])
  end
end

  # def edit
  #   @order = Order.find(params[:id])
  # end

  # def update
  #   @order = Order.find(params[:id])
  #   if @order.update(order_params)
  #     redirect_to order_path(params[:id])
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   Order.destroy(params[:id])
  #   redirect_to orders_path
  # end
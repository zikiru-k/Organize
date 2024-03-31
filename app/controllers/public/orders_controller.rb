class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer

  def index
    @orders = Order.where(group_id: params[:group_id]).page(params[:page]).per(15)
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
      # new_itemsがなにもない場合、バリデーションエラーとする。
      if params[:order].blank? || params[:new_items].blank?
        @order.errors.add(:base, '発注依頼を入力して下さい。')
        render :new
        return
      end
      # 新しい商品を作る場合のdetailに対するバリデーション
      params[:new_items][:name].each_with_index do |name, index|
        next if name.blank?
        if params[:new_items][:amount][index] == "0" || params[:new_items][:amount][index].blank?
          @order.errors.add(:base, '商品の購入数は0以上を入力して下さい。')
          render :new
          return
        end
      end
      # 既存の商品に対してのバリデーション
      params["order"]["order_details_attributes"].each do |value|
        if value[1]["amount"] == "0" || value[1]["amount"].blank?
          @order.errors.add(:base, '商品の購入数は0以上を入力して下さい。')
          render :new
          return
        end
      end


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

        flash[:notice] = "発注願いを出しました。"
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
      flash[:notice] = "ステータスを更新しました。"
      redirect_to group_orders_path(params[:group_id])
    else
      flash.now[:alert] = "ステータスの更新に失敗しました。"
      render :inde
    end
  end

  private

  def order_params

    # return if params[:order].blank? || params[:new_items].blank?

    # モデル名_attributesが子のモデルに保存する要素
    #   :id, :_destroyをつけることで、編集と削除が可能になる
    # params.require(:order)はOrderのカラムが必要なければ書かなくていい
    params.permit(order_details_attributes: [:id, :item_id, :amount, :_destroy])
          .merge(group_id: params[:group_id], customer_id: current_customer.id)
  end

  def stats_params
    params.require(:order).permit(:stats)
  end
end
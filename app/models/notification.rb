class Notification < ApplicationRecord
  belongs_to :customer
  belongs_to :notifiable, polymorphic: true

  # 通知機能関係
  include Rails.application.routes.url_helpers # モデルの中でxxx_pathメソッドを使用するために必要な記述になります。
  def message
    if notifiable_type === "Order"
      "#{notifiable.customer.full_name}さんが#{notifiable.group.name}で発注依頼を出しました"
    else
      "#{notifiable.customer.full_name}さんが#{notifiable.order.group.name}で発注にコメントしました。"
    end
  end

  def notifiable_path
    if notifiable_type === "Order"
      group_order_path(notifiable.group, notifiable)
    else
      group_order_path(notifiable.order.group, notifiable.order)
    end
  end
end

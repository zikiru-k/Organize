class Notification < ApplicationRecord
  belongs_to :customer
  belongs_to :notifiable, polymorphic: true

  # 通知機能関係
  include Rails.application.routes.url_helpers # モデルの中でxxx_pathメソッドを使用するために必要な記述になります。
  def message
    if notifiable_type === "Order"
      "#{notifiable.customer.name}さんが#{notifiable.group.name}で発注依頼を出しました。"
    else
      "#{notifiable.customer.name}さんが＿＿にコメントしました。"
    end
  end

  def notifiable_path
    if notification.notifiable_type === "Order"
      group_orders_path(notifiable.id) # 発注に関する通知の場合はのorderの一覧ページ
    else
      group_order_path(notifiable.user.id) # 発注詳細のコメントに関する通知の場合はorderの詳細ページ
    end
  end
end

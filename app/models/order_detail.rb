class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :amount, presence: true

  # 未発注：not_ordered,　発注中：ordered,　配達済み：delivered,　配達中止：cancel, 在庫あり/使用中: in_stock, 在庫切れ/使い切る: no_stock
  enum stock_stats: { not_ordered: 0, ordered: 1, delivered: 2, cancel: 3, in_stock: 4, no_stock: 5 }

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "id", "item_id", "order_id", "stock_stats", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["item", "order"]
  end
end

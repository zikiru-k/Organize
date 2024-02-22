class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  # 未発注：not_ordered,　発注中：ordered,　配達済み：delivered,　配達中止：cancel, 在庫あり/使用中: in_stock, 在庫切れ/使い切る: no_stock
  enum stock_stats: { not_ordered: 0, ordered: 1, delivered: 2, cancel: 3, in_stock: 4, no_stock: 5 }
end

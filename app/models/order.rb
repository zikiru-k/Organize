class Order < ApplicationRecord
  belongs_to :group
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy

  # accepts_nested_attributes_forは、親モデルを保存するときに、Associationで関連づけた子モデルも一緒に保存することができるメソッド
  # reject_ifは、入力フォームを追加しているもののすべてが空白の場合にリジェクトする
  # allow_destroyは、入力フォームでこのオブジェクトが削除された際に削除を許可する
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true

  # 未発注：not_ordered,発注中：order,配達済み：delivered,配達中止：cancel
  # enum :stats, { not_ordered: 0, order: 1, delivered: 2, cancel: 3 }
  enum stats: { not_ordered: 0, ordered: 1, delivered: 2, cancel: 3 }
end

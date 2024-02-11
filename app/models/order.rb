class Order < ApplicationRecord
  belongs_to :group
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :orderer, class_name: "Customer"

  # accepts_nested_attributes_forは、親モデルを保存するときに、Associationで関連づけた子モデルも一緒に保存することができるメソッド
  # reject_ifは、入力フォームを追加しているもののすべてが空白の場合にリジェクトする
  # allow_destroyは、入力フォームでこのオブジェクトが削除された際に削除を許可する
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
  
  
end

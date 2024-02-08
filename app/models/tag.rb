class Tag < ApplicationRecord
  has_many :order_tag_relations, dependent: :destroy, foreign_key: 'tag_id'
  # itemsのアソシエーション
  #   Tag.itemsとすれば、タグに紐付けられたItemを取得可能になる
  has_many :items, through: :order_tag_relations
end

class Tag < ApplicationRecord
  has_many :order_tag_relations, dependent: :destroy
end

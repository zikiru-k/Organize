class Order < ApplicationRecord
  belongs_to :group
  has_many :comments, dependent: :destroy
  has_many :order_details
  belongs_to :orderer, class_name: "Customer"
end

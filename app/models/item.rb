class Item < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end

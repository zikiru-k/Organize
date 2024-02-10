class Comment < ApplicationRecord
  belongs_to :order
  has_many :bookmarks, dependent: :destroy
  
  def bookmark_by?(customer)
    bookmarks.exists?(customer_id: customer.id)
  end
end

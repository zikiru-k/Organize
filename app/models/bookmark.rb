class Bookmark < ApplicationRecord
  belongs_to :customer
  belongs_to :comment

  validates :customer_id, uniqueness: {scope: :comment_id}
end

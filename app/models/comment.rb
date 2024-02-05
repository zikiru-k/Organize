class Comment < ApplicationRecord
  belongs_to :order
  has_many :bookmarks, dependent: :destroy
end

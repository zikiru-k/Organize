class Comment < ApplicationRecord
  belongs_to :order
  belongs_to :customer
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, length: { maximum: 300 }

  def bookmark_by?(customer)
    bookmarks.exists?(customer_id: customer.id)
  end

  after_create do
    order.group.group_users.each do |customer|
      Notification.create(customer_id: customer.id, notifiable_type: "Comment", notifiable_id: id)
    end
  end
end

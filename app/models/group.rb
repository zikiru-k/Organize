class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :customers, through: :group_users
  has_many :orders, dependent: :destroy
  has_many :items, dependent: :destroy
  belongs_to :owner, class_name: "Customer"
  belongs_to :permit, class_name: "Customer"

  validates :name, presence: true
  validates :content, presence: true

  def is_owned_by?(customer)
    owner.id == customer.id
  end

  def include_customer?(customer)
    group_users.exists?(customer_id: customer.id)
  end
end

class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'Customer'
  has_many :cstomers, through: :group_users, source: :customer
  has_many :orders, dependent: :destroy

  def is_owned_by?(user)
    owner.id == user.id
  end

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end
end

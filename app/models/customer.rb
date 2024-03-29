class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :bookmarks, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :telephone_number, presence: true

  def customer_status
    if is_active?
      "有効"
    else
      "退会"
    end
  end

  def full_name
    last_name + " " + first_name
  end

  GUEST_MEMBER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.first_name = "ゲスト"
      customer.last_name = "ゲスト"
      customer.telephone_number = "00000000000"
      # customer.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， customer.name = "ゲスト" なども必要
    end
  end

  def guest_customer?
    email == GUEST_MEMBER_EMAIL
  end
end

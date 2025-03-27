class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items, dependent: :destroy
  has_many :orders
  has_many :addresses,  dependent: :destroy
  
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字のみで入力してください（ハイフンなし）" }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "は10桁もしくは11桁の数字のみで入力してください（ハイフンなし）"}
  validates :email, uniqueness: true

  def active_for_authentication?
    super && (is_active == true)
  end

  # 検索機能のためのメソッド
  scope :search_by_fullname, ->(query, match_type) {
    case match_type
    when 'partial' then where("CONCAT(family_name, first_name) LIKE ?", "%#{query}%")
    else all
    end
  }

end

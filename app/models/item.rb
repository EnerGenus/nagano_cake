class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  belongs_to :genre
  has_one_attached :item_image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :item_image, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

  # 検索機能のためのメソッド
  scope :search_by_name, ->(query, match_type) {
    case match_type
    when 'partial' then where('name LIKE ?', "%#{query}%")
    else all
    end
  }

end

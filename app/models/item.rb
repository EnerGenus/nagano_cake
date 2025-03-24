class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  belongs_to :genre
  has_one_attached :item_image

  validates :name, presence: true
  validates :description, presence: true
  validates :genre, presence: true
  
  def with_tax_price
    (price * 1.1).floor
  end
end

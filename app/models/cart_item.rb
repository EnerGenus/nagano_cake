class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  belongs_to :order

  def subtotal
    item.price_including_tax * quantity
  end

end

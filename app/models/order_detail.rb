class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum making_status: { not_available: 0, wait: 1, making: 2, complete:3 }
end

class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_detail, dependent: :destroy
  
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字のみで入力してください（ハイフンなし）" }
  validates :address, presence: true
  validates :name, presence: true

  enum status: { waiting_for_payment: 0, payment_confirmed: 1, in_production: 2, preparing_for_shipment: 3, shipped: 4}
  enum payment_method: { credit_card: 0, transfer: 1 }

end

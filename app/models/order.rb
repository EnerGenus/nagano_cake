class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_detail, dependent: :destroy
  
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字のみで入力してください（ハイフンなし）" }
  validates :address, presence: true
  validates :name, presence: true

  enum status: {
    waiting_for_payment: 0,  # 入金待ち
    payment_confirmed: 1,    # 入金確認
    in_production: 2,        # 製作中
    preparing_for_shipment: 3, # 発送準備中
    shipped: 4               # 発送済み
  }

  enum payment_method: { credit_card: 0, transfer: 1 }

  # ステータスの日本語化
  def self.statuses_i18n
    statuses.keys.map { |key| [I18n.t("enums.order.status.#{key}"), key] }
  end
end


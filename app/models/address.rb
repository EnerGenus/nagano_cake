class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字のみで入力してください（ハイフンなし）" }
  validates :address, presence: true
  validates :name, presence: true

  # view/pubric/orders/new.html.erbで使うメソッド
  def full_address
    "〒#{post_code} #{address} #{name}"
  end

end

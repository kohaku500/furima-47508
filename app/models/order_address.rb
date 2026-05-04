class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :addresses
    # 電話番号は10桁または11桁の数字のみを許可
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :token
  end

  def save
    # 購入記録を保存し、変数orderに代入
    order = Order.create(item_id: item_id, user_id: user_id)
    # 寄付金住所を保存する
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end

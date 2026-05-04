# app/models/order_address.rb

class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  # ↓ ここが「presence: true（空欄を禁止する）」の設定箇所です
  with_options presence: true do
    validates :user_id
    validates :item_id
    # postal_codeの行に「presence: true」が漏れていないか確認し、以下のように書き換えます
    validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :addresses
    validates :phone_number, format: {with: /\A\d{10,11}\z/}
    validates :token
  end

  # （以下、saveメソッドなどの記述が続きます）
end
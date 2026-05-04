class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  # ここにバリデーション（入力チェック）を書く

  def save
    # ここに保存の命令を書く
  end
end
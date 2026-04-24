class CreateItems < ActiveRecord::Migration[7.0]
  # 商品テーブル
  def change
    create_table :items do |t|
      # 商品名が必須であること
      t.string     :name,                   null: false
      # 商品の説明が必須であること
      t.text       :info,                   null: false
      # カテゴリーの情報が必須であること
      t.integer    :category_id,            null: false
      # 商品の状態の情報が必須であること
      t.integer    :sales_status_id,        null: false
      # 配送料の負担の情報が必須であること
      t.integer    :shipping_fee_status_id, null: false
      # 発送元の地域の情報が必須であること
      t.integer    :prefecture_id,          null: false
      # 発送までの日数の情報が必須であること
      t.integer    :scheduled_delivery_id,  null: false
      # 価格の情報が必須であること
      t.integer    :price,                  null: false
      # 出品者の情報が必須であること
      t.references :user,                   null: false, foreign_key: true
      # 商品画像を1枚付けることが必須であること
      t.timestamps
    end
  end
end

class Item < ApplicationRecord
  # ActiveHashを使用して、カテゴリーや販売状況などの選択肢を管理します
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  # Active Storageを使用して、画像を添付できるようにします
  has_one_attached :image

  # 「商品画像を1枚付けることが必須であること」
  validates :image,                  presence: true
  # 「商品名が必須であること」
  validates :name,                   presence: true
  # 「商品の説明が必須であること」
  validates :info,                   presence: true
  # 「カテゴリーの情報が必須であること」
  validates :category_id,            numericality: { other_than: 1 , message: "can't be blank"}
  # 「商品の状態の情報が必須であること」
  validates :sales_status_id,        numericality: { other_than: 1 , message: "can't be blank"}
  # 「配送料の負担の情報が必須であること」
  validates :shipping_fee_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  # 「発送元の地域の情報が必須であること」
  validates :prefecture_id,          numericality: { other_than: 1 , message: "can't be blank"}
  # 「発送までの日数の情報が必須であること」
  validates :scheduled_delivery_id,  numericality: { other_than: 1 , message: "can't be blank"}
  # 価格は、¥300〜¥9,999,999の間のみ保存可能なこと
  # 価格は半角数字のみ保存可能なこと
  # 価格が空では保存できないこと
  # 価格が設定範囲外の場合は保存できないこと
  # 価格が半角数字以外の場合は保存できないこと
  validates :price,                  presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "is out of setting range" }
end

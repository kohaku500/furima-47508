class ShippingFeeStatus < ActiveHash::Base
  # 3項目が表示されること（---は初期値として設定すること）
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '着払い(購入者負担)' },
    { id: 3, name: '送料込み(出品者負担)' }
  ]

  include ActiveHash::Associations
  has_many :items
end
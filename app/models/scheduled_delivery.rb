class ScheduledDelivery < ActiveHash::Base
  # 4項目が表示されること（---は初期値として設定すること）
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '1~2日で発送' },
    { id: 3, name: '2~3日で発送' },
    { id: 4, name: '4~7日で発送' }
  ]

  include ActiveHash::Associations
  has_many :items
end
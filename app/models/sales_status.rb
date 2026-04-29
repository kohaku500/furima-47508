class SalesStatus < ActiveHash::Base
  # 7項目が表示されること（--- は初期値として設定すること）
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '新品・未使用' },
    { id: 3, name: '未使用に近い' },
    { id: 4, name: 'にかかった傷や汚れなし' },
    { id: 5, name: 'やや傷や汚れあり' },
    { id: 6, name: '傷や汚れあり' },
    { id: 7, name: '全体的に状態が悪い' }
  ]

  include ActiveHash::Associations
  has_many :items
end

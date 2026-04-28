class User < ApplicationRecord
  # Deviseの標準的な5つの機能（モジュール）を有効にします
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # データベースに保存するためのバリデーション（入力ルール）
  # すべて「必須（空欄禁止）」に設定しています
  validates :nickname, presence: true
  validates :birth_date, presence: true

  # お名前(全角)のバリデーション（全角漢字・ひらがな・カタカナのみ許可）
  # 漢字・ひらがな・カタカナ以外の入力（アルファベットなど）を弾きます
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :first_name
    validates :last_name
  end

  # お名前カナ(全角)のバリデーション（全角カタカナのみ許可）
  # カタカナ以外の入力を弾きます
  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/ } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # パスワードのバリデーション（半角英数字混合のみ許可）
  # 英字のみ、数字のみのパスワードを弾き、セキュリティを高めます
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
end

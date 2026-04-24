require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  # -----------------------------------------------------------
  # 【RSpec以外のチェック項目】

  # # 1.ログイン状態の場合は、商品出品ページへ遷移できる動画
  # https://gyazo.com/c385a59e17222cc40523c35eb2938e94

  # # 2.価格が入力される瞬間、販売手数料と販売利益が表示される動画
  # https://gyazo.com/ade5422a6496e53476f64798ea54fadb

  # # 3.必要な情報を正しく入力して「出品する」ボタンを押すと、商品情報がデータベースに保存される動画
  # https://gyazo.com/9bd062c6fbecf7257ecfaa2afa163c22

  # # 4.入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに返品エラーメッセージが表示される動画
  # https://gyazo.com/a3841e3b52f2d181c9cac921cdc1139c

  # # 5.ログアウト状態の場合は、商品出品ページへ移行しようとすると、ログインページへ移行する動画
  # https://gyazo.com/de41160211177fa539a165beccf92840

  # # 6.テスト結果の画像
  # ターミナルで bundle exec rspec spec/models/item_spec.rb を実行し、
  # 14 examples, 0 failures となる結果をスクリーンショットでweb githubに添付

  # #　7.カテゴリー等の各選択肢が正しく表示されること
  #   => ActiveHash（app/models/xxx.rb）の設定で対応

  # #　8.販売手数料や販売利益の表示・小数点切り捨て
  #   => JavaScript（app/javascript/item_price.js）および動画2で確認

  # #　9.出品完了後の遷移・エラー時の挙動（リテインド、重複メッセージなし）
  #   => コントローラーの記述および動画3, 4で確認
  # -----------------------------------------------------------

  describe '商品出品機能' do
    context '出品できるとき' do
      # 必要な情報を正しく入力して「出品する」ボタンを押すと、商品情報がデータベースに保存されること
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      # 商品画像を1枚付けることが必須であること
      it '商品画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      # 商品名が必須であること
      it '商品名が空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      # 商品の説明が必須であること
      it '商品の説明が空では出品できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      # カテゴリーの情報が必須であること
      it 'カテゴリーの情報が「---」(id:1)では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      # 商品の状態の情報が必須であること
      it '商品の状態の情報が「---」(id:1)では出品できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end

      # 配送料の負担の情報が必須であること
      it '配送料の負担の情報が「---」(id:1)では出品できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end

      # 発送元の地域の情報が必須であること
      it '発送元の地域の情報が「---」(id:1)では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      # 発送までの日数の情報が必須であること
      it '発送までの日数の情報が「---」(id:1)では出品できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end

      # 価格の情報が必須であること
      it '価格の情報が空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      # 価格は、¥300~¥9,999,999の間のみ保存可能なこと（下限のチェック）
      it '価格が¥300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      # 価格は、¥300~¥9,999,999の間のみ保存可能なこと（上限のチェック）
      it '価格が¥10,000,000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      # 価格は半角数値のみ保存可能なことです
      it '価格が半角数値以外では出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      # userが紐付いていなければ出品できないこと
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end

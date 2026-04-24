class ItemsController < ApplicationController
  # ログイン状態の場合のみ、商品出品ページへ移行できること
  # ログアウト状態の場合は、商品出品ページへ移行しようとすると、ログインページへ移行すること
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # 一覧表示機能は別工程で行うため、一旦空のままにしておく
  end

  # 出品ページ（入力フォーム）を表示する
  def new
    @item = Item.new
  end

  # 必要な情報を正しく入力して「出品する」ボタンを押すと、商品情報がデータベースに保存されること
  # 出品が完了したら、トップページに進むこと
  # エラーハンドリングができること（入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに返品エラーメッセージが表示されること）
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      # 保存に失敗した場合は、入力内容を保持したまま出品ページに戻る
      render :new, status: :unprocessable_entity
    end
  end

  private

  # ストロングパラメーターの設定
  def item_params
    params.require(:item).permit(
      :image, :name, :info, :category_id, :sales_status_id, 
      :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price
    ).merge(user_id: current_user.id)
  end
end

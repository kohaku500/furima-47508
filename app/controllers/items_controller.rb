class ItemsController < ApplicationController
  # 1. 共通処理をアクションの実行前に呼び出す
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]  
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
    # before_actionで@itemがセットされるため空でOK
  end

  def new
    @item = Item.new
  end

  def edit
    # before_actionで@itemがセットされ、move_to_indexで出品者チェックも済んでいるため空でOK
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      # エラーがある場合は編集画面を再表示（statusを指定してRails 7以降の挙動に対応）
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # ストロングパラメーター
  def item_params
    params.require(:item).permit(
      :image, :name, :info, :category_id, :sales_status_id,
      :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price
    ).merge(user_id: current_user.id)
  end

  # 特定の商品を1箇所で取得する設定
  def set_item
    @item = Item.find(params[:id])
  end

  # 出品者以外をトップページへ戻す設定
  def move_to_index
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
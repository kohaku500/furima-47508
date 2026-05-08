require 'payjp'
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  # ↓ 追記：アクセス制限のメソッドを呼び出す（set_itemより後に記述）
  before_action :move_to_index, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    @payjp_public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  # ↓ 追記：アクセス制限のロジック
  def move_to_index
    redirect_to new_user_session_path unless current_user
    return unless current_user.id == @item.user_id || @item.order.present?
    redirect_to root_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end

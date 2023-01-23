class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_root , only: [:index, :create]
  

  def index
    @buy_delivery = BuyDelivery.new
  end


  def new
    @buy_delivery = BuyDelivery.new
  end

  def create
    @buy_delivery = BuyDelivery.new(buy_params)
    if @buy_delivery.valid?
      pay_item
      @buy_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def buy_params
    params.require(:buy_delivery).permit(:postal_code, :delivery_area_id, :municipalities, :address, :building, :telephone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
  end

  def redirect_root
    if @item.user_id == current_user.id || @item.buy != nil
      redirect_to root_path
    end
  end


end

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  # before_action :move_to_index, except: [:index, :new, :create]

  def index
    @item = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :detail, :category_id, :condition_id, :delivery_charge_id,
                                 :delivery_area_id, :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  # def move_to_index
  # @item = Item.find(params[:id])
  # return if @item.user == current_user

  # redirect_to action: :index
  # end
end

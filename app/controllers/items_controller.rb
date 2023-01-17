class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit]
  before_action :move_to_index, except: %i[index new create show]
  before_action :set_item, only: %i[show edit update]
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

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :detail, :category_id, :condition_id, :delivery_charge_id,
                                 :delivery_area_id, :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    return if @item.user == current_user

    redirect_to action: :index
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

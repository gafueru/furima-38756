class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit]
  before_action :set_item, only: %i[show edit update destroy]
  before_action :move_to_index, except: %i[index new create show]
  before_action :edit_redirect, only: :edit

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

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :detail, :category_id, :condition_id, :delivery_charge_id,
                                 :delivery_area_id, :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    return if @item.user == current_user

    redirect_to action: :index
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def edit_redirect
    return unless @item.user_id == current_user.id && !@item.buy.nil?

    redirect_to root_path
  end
end

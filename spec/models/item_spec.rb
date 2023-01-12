require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
      it '入力内容が全て正しいとき' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できないとき' do
    end
  end
end

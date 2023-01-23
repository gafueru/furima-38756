require 'rails_helper'

RSpec.describe BuyDelivery, type: :model do
  describe '配送先入力' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @buy_delivery = FactoryBot.build(:buy_delivery, item_id: item.id, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@buy_delivery).to be_valid
      end
      it 'buildingが空でも保存できる' do
        @buy_delivery.building = ''
        expect(@buy_delivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空の場合' do
        @buy_delivery.postal_code = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んでいない場合' do
        @buy_delivery.postal_code = '1234567'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'delivery_area_idが空の場合' do
        @buy_delivery.delivery_area_id = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Delivery area can't be blank")
      end
      it 'delivery_area_idが未選択の場合' do
        @buy_delivery.delivery_area_id = '1'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Delivery area can't be blank")
      end
      it 'municipalitiesが空の場合' do
        @buy_delivery.municipalities = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'addressが空の場合' do
        @buy_delivery.address = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Address can't be blank")
      end
      it 'telephone_numberが空の場合' do
        @buy_delivery.telephone_number = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberが10桁より少ない場合' do
        @buy_delivery.telephone_number = '090123456'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Telephone number is invalid')
      end
      it 'telephone_numberが11桁より多い場合' do
        @buy_delivery.telephone_number = '090123456789'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Telephone number is invalid')
      end
      it 'telephone_numberが半角数字じゃない場合' do
        @buy_delivery.telephone_number = '０９０１２３４５６７８'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Telephone number is invalid')
      end
      it 'tokenが空の場合' do
        @buy_delivery.token = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空の場合' do
        @buy_delivery.user_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空の場合' do
        @buy_delivery.item_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

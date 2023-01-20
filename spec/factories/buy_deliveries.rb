FactoryBot.define do
  factory :buy_delivery do
    postal_code { '123-4567' }
    delivery_area_id { 2 }
    municipalities { '滋賀県東近江市外町' }
    address { '1380' }
    building { 'プラシード緑町 '}
    telephone_number { '09012345678' }
  end
end

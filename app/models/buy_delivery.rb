class BuyDelivery
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_area_id, :municipalities, :address, :building, :telephone_number, :item_id, :user_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :delivery_area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipalities
    validates :address
    validates :telephone_number, format: {with: /\A\d{10,11}\z/}
  end

  

  def save
    buy = Buy.create(item_id: item_id, user_id: user_id)
    Delivery.create(postal_code: postal_code, delivery_area_id: delivery_area_id, municipalities: municipalities, address: address, building: building, telephone_number: telephone_number, item_id: item_id, buy_id: buy_id)
  end
end
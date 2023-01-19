class BuyDelivery
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_area_id, :municipalities, :address, :building, :telephone_number, :item_id, :user_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :delivery_area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipalities
    validates :address
  end

  validates :telephone_number, presence :true, numericality :only_integer: true, format: {with: /\A\d{10,11}\z/}
end
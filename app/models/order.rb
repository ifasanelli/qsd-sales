class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  validates :product_id, :price_id, :plan_id, presence: true
end

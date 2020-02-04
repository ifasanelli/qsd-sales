class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  validates :product, :price, :plan, presence: true
end

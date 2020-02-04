class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  validates :product, presence: true
end

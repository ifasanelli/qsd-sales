class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  
  validates :product, presence: { message: 'Produto não pode ficar em branco' }
end

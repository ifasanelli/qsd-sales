class Customer < ApplicationRecord
  has_many :orders
  def identification
    "#{name} - #{document}"
  end
end

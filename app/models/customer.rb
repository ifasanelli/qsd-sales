class Customer < ApplicationRecord
  has_many :orders, dependent: :restrict_with_exception
  def identification
    "#{name} - #{document}"
  end
end

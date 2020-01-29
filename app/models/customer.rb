class Customer < ApplicationRecord
  def identification
    "#{name} - #{document}"
  end
end

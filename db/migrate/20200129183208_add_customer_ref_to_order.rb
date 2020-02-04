class AddCustomerRefToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :customer, foreign_key: true
  end
end

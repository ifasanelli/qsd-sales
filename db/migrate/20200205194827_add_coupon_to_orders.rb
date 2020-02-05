class AddCouponToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :coupon, :integer
  end
end

class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.date :date_order
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :costumer, null: false, foreign_key: true
      t.string :product

      t.timestamps
    end
  end
end

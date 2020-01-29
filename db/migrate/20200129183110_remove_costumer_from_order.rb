class RemoveCostumerFromOrder < ActiveRecord::Migration[6.0]
  def change
    remove_index :orders, :costumer_id

    remove_column :orders, :costumer_id, :integer
  end
end

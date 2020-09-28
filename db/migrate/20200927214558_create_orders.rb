class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.integer :order_total

      t.timestamps
    end
  end
end

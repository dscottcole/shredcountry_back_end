class CreateJoinTableBikeOrder < ActiveRecord::Migration[6.0]
  def change
    create_join_table :bikes, :orders do |t|
      t.index [:bike_id, :order_id]
      t.index [:order_id, :bike_id]
    end
  end
end

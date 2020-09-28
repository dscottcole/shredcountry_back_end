class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.string :manufacturer
      t.string :model
      t.string :bike_type
      t.string :size
      t.string :build
      t.integer :price
      t.string :image
      t.text :details

      t.timestamps
    end
  end
end

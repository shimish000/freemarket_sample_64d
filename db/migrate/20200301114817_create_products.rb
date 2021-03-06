class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :detail, null: false
      t.string :size
      t.integer :condition_id, null: false
      t.string :brand, null: false
      t.references :category, null: false
      t.string :shipping_fee_id
      t.string :shipping_date_id, null: false
      t.string :shipping_s_area_id, null: false
      t.integer :saler_id, null: false
      t.integer :buyer_id
      
      t.timestamps
    end
  end
end

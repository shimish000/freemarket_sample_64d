class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :detail, null: false
      t.string :size, null: false
      t.integer :condition_id, null: false
      # t.references :brand, null: false, foreign_key: true
      # t.references :category, null: false, foreign_key: true
      t.string :shipping_fee_id
      t.string :shipping_date_id, null: false
      t.string :shipping_s_area_id, null: false
      t.references :sell, null: false
      t.references :buy, null: false
      
      t.timestamps
    end
  end
end

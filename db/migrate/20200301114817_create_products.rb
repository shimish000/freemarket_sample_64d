class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :size 
      t.string :condition 
      t.text :detail 
      t.references :brand  
      t.references :category  
      t.string :shipping_fee
      t.string :shippng_method 
      t.string :shipping_date 
      t.string :shipping_s_area 
      t.references :sell  
      t.references :buy  
      t.timestamps
    end
  end
end

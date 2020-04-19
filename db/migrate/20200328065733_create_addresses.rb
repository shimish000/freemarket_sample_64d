class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name,               null: false
      t.string :last_name,               null: false
      t.string :first_name_kana,               null: false
      t.string :last_name_kana,               null: false
      t.string :number,               null: false
      t.integer :prefecture_id,               null: false
      t.string :municipality,               null: false
      t.string :address,               null: false
      t.string :building_name
      t.string :address_phone
      t.references :user
    end
  end
end

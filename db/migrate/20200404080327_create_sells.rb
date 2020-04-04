class CreateSells < ActiveRecord::Migration[5.2]
  def change
    create_table :sells do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

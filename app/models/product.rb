class Product < ApplicationRecord
  belongs_to :saler, class_name: "User", foreign_key: 'saler_id'
  belongs_to :buyer, optional: true, class_name: "User",foreign_key: 'buyer_id'
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy:true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :shipping_s_area
  belongs_to_active_hash :shipping_date

  def self.search(search)
    if search
      Product.where('name LIKE(?)', "%#{search}%")
    else
      Product.all
    end
  end
  
end

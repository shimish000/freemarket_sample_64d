class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :product
#   mount_uploader :image_url, ImageUploader
end

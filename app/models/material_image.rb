class MaterialImage < ApplicationRecord
  belongs_to :material
  mount_uploader :src, ImageUploader
end

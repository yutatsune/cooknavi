class How < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validates :how, presence: true
  belongs_to :recipe
end

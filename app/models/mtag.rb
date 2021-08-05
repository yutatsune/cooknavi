class Mtag < ApplicationRecord
  has_many   :material_tags, dependent: :destroy
  has_many   :materials, through: :material_tags
  validates :tag_name, uniqueness: true
end

class MaterialComment < ApplicationRecord
  validates :text, presence: true
  belongs_to :material
  belongs_to :user
end

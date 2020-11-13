class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :material
end

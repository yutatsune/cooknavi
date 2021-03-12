class How < ApplicationRecord
  validates :how, presence: true
  belongs_to :recipe
end

class Recipe < ApplicationRecord
  validates :text, presence: true
end

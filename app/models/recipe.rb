class Recipe < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  def self.search(search)
    if search
      Recipe.where('name LIKE(?)', "%#{search}%")
    else
      Recipe.all
    end
  end
end

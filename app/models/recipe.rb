class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :material, presence: true
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  has_many :images, dependent: :destroy
  has_many :likes
  has_many :users, through: :likes
  accepts_nested_attributes_for :images, allow_destroy: true

  def self.search(search)
    if search != ""
      Recipe.where('name LIKE(?)', "%#{search}%")
    else
      Recipe.all
    end
  end
end

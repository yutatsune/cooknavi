class Recipe < ApplicationRecord
  validates_associated :images
  validates :images, presence: true
  validates :name, presence: true
  validates :explanation, presence: true
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  has_many :images, dependent: :destroy
  has_many :foodstuffs, dependent: :destroy
  has_many :recipe_likes
  has_many :liked_users, through: :recipe_likes, source: :user
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :foodstuffs, allow_destroy: true

  def self.search(search)
    if search != ""
      Recipe.where('name LIKE(?)', "%#{search}%")
    else
      Recipe.all
    end
  end
end

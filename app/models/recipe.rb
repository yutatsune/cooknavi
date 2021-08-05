class Recipe < ApplicationRecord
  validates_associated :images
  validates :images, presence: true
  validates :name, presence: true
  validates :explanation, presence: true
  belongs_to :user
  has_many :comments
  has_many :images, dependent: :destroy
  has_many :foodstuffs, dependent: :destroy
  has_many :hows, dependent: :destroy
  has_many :recipe_likes
  has_many :liked_users, through: :recipe_likes, source: :user
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :foodstuffs, allow_destroy: true
  accepts_nested_attributes_for :hows, allow_destroy: true

  def self.create_recipe_ranks
    Recipe.find(RecipeLike.group(:recipe_id).order('count(recipe_id) desc').limit(3).pluck(:recipe_id))
  end

  def save_recipes(tags)
    return unless tags.length <= 3

    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end
    # Create
    new_tags.each do |new_name|
      recipe_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << recipe_tag
    end
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes
  has_many :comments
  has_many :materials
  has_many :recipe_likes
  has_many :recipe_favorites, through: :recipe_likes, source: :recipe

  def recipe_like_this(clicked_recipe)
    self.recipe_likes.find_or_create_by(recipe_id: clicked_recipe.id)
    binding.pry
  end
end

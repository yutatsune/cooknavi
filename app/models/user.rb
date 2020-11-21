class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes
  has_many :comments
  has_many :materials
  has_many :recipe_likes
  has_many :liked_recipes, through: :recipe_likes, source: :recipe
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_rerationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_rerationships, source: :user
  def already_liked?(recipe)
    self.recipe_likes.exists?(recipe_id: recipe.id)
  end
end

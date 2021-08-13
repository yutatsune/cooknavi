class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :material_comments, dependent: :destroy
  has_many :recipe_likes
  has_many :liked_recipes, through: :recipe_likes, source: :recipe
  has_many :material_likes
  has_many :liked_materials, through: :material_likes, source: :material
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_rerationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_rerationships, source: :user

  validates :nickname, presence: true, length: { maximum: 6 }

  def already_liked?(recipe)
    recipe_likes.exists?(recipe_id: recipe.id)
  end

  def material_already_liked?(material)
    material_likes.exists?(material_id: material.id)
  end

  def follow(other_user)
    return if self == other_user

    relationships.find_or_create_by(follow: other_user)
  end

  def unfollow(relationship_id)
    relationships.find(relationship_id).destroy!
  end

  def following?(user)
    followings.include?(user)
  end

  def self.guest
    find_or_create_by!(nickname: 'ゲスト', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

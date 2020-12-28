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

  validates :nickname, presence: true, length: { maximum: 6 }

  def already_liked?(recipe)
    recipe_likes.exists?(recipe_id: recipe.id)
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def self.guest
    find_or_create_by!(nickname: 'ゲスト', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

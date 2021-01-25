class Material < ApplicationRecord
  validates_associated :material_images
  validates :material_images, presence: true
  validates :name, presence: true
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :explanation, presence: true
  belongs_to :user
  has_many :material_comments
  has_many :material_likes
  has_many :liked_users, through: :material_likes, source: :user
  has_many :material_images, dependent: :destroy
  accepts_nested_attributes_for :material_images, allow_destroy: true

  def self.search(search)
    if search != ""
      Material.where('name LIKE(?)', "%#{search}%")
    else
      Material.all
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  geocoded_by :address_city
  after_validation :geocode
end

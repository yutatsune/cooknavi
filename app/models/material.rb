class Material < ApplicationRecord
  validates_associated :material_images
  validates :material_images, presence: true
  validates :name, presence: true
  validates :shop, presence: true
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :explanation, presence: true
  belongs_to :user
  has_many :material_comments
  has_many :material_likes
  has_many :liked_users, through: :material_likes, source: :user
  has_many :material_images, dependent: :destroy
  has_many :material_tags, dependent: :destroy
  has_many :mtags, through: :material_tags
  accepts_nested_attributes_for :material_images, allow_destroy: true

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

  def self.create_material_ranks
    Material.find(MaterialLike.group(:material_id).order('count(material_id) desc').limit(3).pluck(:material_id))
  end

  def save_materials(mtags)
    return unless mtags.length <= 3

    current_tags = self.mtags.pluck(:tag_name) unless self.mtags.nil?
    old_tags = current_tags - mtags
    new_tags = mtags - current_tags
    # Destroy
    old_tags.each do |old_name|
      self.mtags.delete Mtag.find_by(tag_name: old_name)
    end
    # Create
    new_tags.each do |new_name|
      material_tag = Mtag.find_or_create_by(tag_name: new_name)
      self.mtags << material_tag
    end
  end
end

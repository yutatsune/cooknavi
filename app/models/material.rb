class Material < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  belongs_to :user

  def self.search(search)
    if search != ""
      Material.where('name LIKE(?)', "%#{search}%")
    else
      Material.all
    end
  end
end

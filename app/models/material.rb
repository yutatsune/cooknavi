class Material < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true

  def self.search(search)
    if search != ""
      Material.where('name LIKE(?)', "%#{search}%")
    else
      Material.all
    end
  end
end

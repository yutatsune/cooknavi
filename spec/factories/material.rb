FactoryBot.define do
  factory :material do
    name             { "卵" }
    shop             { "高島屋　大宮店" }
    postcode         { "3308511" }
    prefecture_code  { "11" }
    address_city     { "さいたま市大宮区大門町１丁目３２" }
    address_building { "株式会社　高島屋　大宮店" }
    explanation      { "卵です！" }
    user { create(:user) }
    after(:build) do |material|
      material.material_images << FactoryBot.build(:material_image, material: material)
    end
  end
end

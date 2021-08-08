FactoryBot.define do

  factory :material_image do
    src   {File.open("#{Rails.root}/spec/fixtures/test.jpg")}
    material
  end

end
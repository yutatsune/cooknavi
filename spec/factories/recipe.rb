FactoryBot.define do
  factory :recipe do
    name        { "パンケーキ" }
    explanation { "パンケーキです！" }
    material    { "●小麦粉 100g" }
    text        { "ボウルにＡをふるい入れ、泡立て器で混ぜる。" }
    user        { create(:user) }
    after(:build) do |recipe|
      recipe.images << FactoryBot.build(:image, recipe: recipe)
    end
  end

  factory :image do
    src       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
  end
end


FactoryBot.define do
  factory :recipe do
    name        { "パンケーキ" }
    explanation { "パンケーキです！" }
    user        { create(:user) }
    after(:build) do |recipe|
      recipe.images << FactoryBot.build(:image, recipe: recipe)
      recipe.foodstuffs << FactoryBot.build(:foodstuff, recipe: recipe)
      recipe.hows << FactoryBot.build(:how, recipe: recipe)
    end
  end
end

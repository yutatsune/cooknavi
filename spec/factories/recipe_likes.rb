FactoryBot.define do
  factory :recipe_like do
    association :recipe
    user { recipe.user }
  end
end
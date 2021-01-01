FactoryBot.define do
  factory :recipe do
    name      { "パンケーキ" }
    material  { "●小麦粉 100g" }
    text      { "ボウルにＡをふるい入れ、泡立て器で混ぜる。" }
    user_id   { "1" }
  end
end
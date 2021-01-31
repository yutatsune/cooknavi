FactoryBot.define do
  factory :user do
    nickname              { "hoge" }
    sequence(:email)      { |n| "hoge#{n}@gmail.com" }
    password              { "hoge0000" }
    password_confirmation { "hoge0000" }
  end
end

FactoryBot.define do
  factory :list do
    title { 'test_list' }
    share_hash { Faker::Number.hexadecimal(digits: 10) }
    association :user
  end
end
FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    name { 'John Doe' }
    password { 'password' }
  end
end
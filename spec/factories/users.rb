FactoryBot.define do
  factory :user do
    name { 'yui' }
    email { 'yui@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

FactoryBot.define do
  factory :yuri, class: User do
    name { 'yuri' }
    email { 'yuri@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
  
  factory :taro, class: User do
    name { 'taro' }
    email { 'taro@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

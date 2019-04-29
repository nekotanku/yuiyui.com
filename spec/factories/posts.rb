FactoryBot.define do
  factory :yuri_post, class: Post do
    content { "猫が好き" }
    association :user, factory: :yuri
  end

  factory :taro_post, class: Post do
    content { "犬が好き" }
    association :user, factory: :taro
  end
end

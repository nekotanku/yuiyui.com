FactoryBot.define do
  factory :like do
    association :user, factory: :yuri
    association :article, factory: :taro_article
  end
end
FactoryBot.define do
  factory :news_source, class: NewsSource do
    sequence(:name) { |n| "Fonte de notícia #{n}" }
    url { "www.g1.com.br" }
    credibility { "" }
  end
end
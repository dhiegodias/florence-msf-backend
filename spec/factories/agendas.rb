FactoryBot.define do
  factory :agenda, class: Agenda do
    sequence(:title) { |n| "Agenda #{n}" }
    keywords { [] }
  end
end

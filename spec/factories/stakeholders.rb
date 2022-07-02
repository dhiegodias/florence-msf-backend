FactoryBot.define do
  factory :stakeholder, class: Stakeholder do
    sequence(:name) { |n| "Stakeholder #{n}" }
  end
end
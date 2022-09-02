FactoryBot.define do
  factory :ticket do
    title {"string"}
    description {"new string"}
    state {:backlog}
  end
end

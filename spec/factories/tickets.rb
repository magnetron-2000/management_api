FactoryBot.define do
  factory :ticket do
    title {"string"}
    description {"new string"}
    worker_id {nil}
    state {true}
  end
end

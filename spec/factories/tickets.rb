FactoryBot.define do
  factory :ticket do
    title {"string"}
    description {"new string"}
    worker_id {1}
    state {"Pending"}
    #worker
  end
end

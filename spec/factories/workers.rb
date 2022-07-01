FactoryBot.define do
  factory :worker do
    last_name {"Doe"}
    first_name {"John"}
    age {30}
    role {"Manager"}
    active {true}
  end
end

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@mail.com"
    end
      password { "secret" }
      password_confirmation { "secret" }
      worker {association :worker, user: instance}
  end
end
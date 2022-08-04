FactoryBot.define do
  factory :user do
      email { "hello@mail.com" }
      password { "secret" }
      password_confirmation { "secret" }
      association :worker, factory: :worker
  end
end
FactoryBot.define do
  factory :user do
        email {"third@mail.com"}
        password {'secret'}
        password_confirmation {'secret'}
  end
end
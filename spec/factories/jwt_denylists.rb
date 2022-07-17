FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2022-07-17 18:21:35" }
  end
end

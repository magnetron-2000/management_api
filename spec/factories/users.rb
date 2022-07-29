FactoryBot.define do
  factory :user do
      email { "hello@mail.com" }
      password { "secret" }
      password_confirmation { "secret" }
      worker_attributes {
        first_name { "greeting" }
        last_name { "hi" }
        age { 30 }
        role { "Developer" } }
  end
end

#
# { "user": {
#   "email": "dfddfdfddsfd@mail.com",
#   "password": "secret",
#   "password_confirmation": "secret",
#   "worker_attributes": {
#     "first_name": "dffdfdfdfdfd",
#     "last_name": "Bradi",
#     "age": 30,
#     "role": "Developer" } } }
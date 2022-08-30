FactoryBot.define do
  factory :comment do
    sequence :message do |n|
      "hello word number #{n}"
    end
    reply_to_comment_id {nil}
      deleted {false}
      created_at { DateTime.now }
      updated_at { DateTime.now }
      parent_id {false}
  end
end

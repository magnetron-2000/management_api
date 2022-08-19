FactoryBot.define do
  factory :comment do
    sequence :message do |n|
      "hello world number #{n}"
    end
    worker_id {1}
    ticket_id {1}
    reply_to_comment_id {nil}
      deleted {false}
      created_at { DateTime.now }
      updated_at { DateTime.now }
      parent_id {false}
  end
end

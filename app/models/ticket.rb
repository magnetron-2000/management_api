class Ticket< ApplicationRecord
  STATE = ["Pending", "In progress", "Done"]
  belongs_to :worker
  validates :title,  length: {maximum: 40}
  validates :worker_id, presence: true
  validates :state, inclusion: { in: STATE, message: "invalid: value" }
end
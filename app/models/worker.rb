class Worker < ApplicationRecord
  STATE = ["Manager", "Developer", "UI/UX Designer"]
  has_many :tickets
  validates :last_name, length: {maximum: 20}
  validates :first_name, length: {maximum: 20}
  validates :age, numericality: { in: 16..60 }
  validates :role, inclusion: { in: STATE, message: "invalid value" }
  validates :active, presence: true
end
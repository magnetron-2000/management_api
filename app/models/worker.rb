class Worker < ApplicationRecord
  has_many :tickets
  validates :last_name, length: {maximum: 20}
  validates :first_name, length: {maximum: 20}
  validates :age, numericality: { in: 16..60 }
  validates :role, inclusion: { in: ["Manager", "Developer", "UI/UX Designer"], message: "invalid value" }
  validates :active, presence: true
end
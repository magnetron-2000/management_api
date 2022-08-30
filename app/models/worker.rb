class Worker < ApplicationRecord
  validates_with WorkerValidator
  STATE = ["Manager", "Developer", "UI/UX Designer"]
  has_many :tickets
  belongs_to :user
  validates :last_name, length: {maximum: 20}
  validates :first_name, length: {maximum: 20}
  validates :age, numericality: { greater_than: 15, less_than: 60 }
  validates :role, inclusion: { in: STATE, message: "invalid value" }
  validates :active, inclusion: {in: [true, false]}

  def activate!
    return false if active

    update(active:true)
  end

  def deactivate!
    return true if Ticket.where(worker_id: id, state: "Pending").or(Ticket.where(worker_id: id, state: "In progress"))

    false
  end
end
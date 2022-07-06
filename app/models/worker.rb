class Worker < ApplicationRecord
  validates_with WorkerValidator
  STATE = ["Manager", "Developer", "UI/UX Designer"]
  has_many :tickets
  validates :last_name, length: {maximum: 20}
  validates :first_name, length: {maximum: 20}
  validates :age, numericality: { greater_than: 15, less_than: 60 }
  validates :role, inclusion: { in: STATE, message: "invalid value" }
  validates :active, inclusion: {in: [true, false]}

  def activate!
    active ? false : true
  end

  def deactivate!
    flag = true
    Ticket.all.each do |ticket|
      if id == ticket.worker_id
        flag = true if ticket.state.include?("Pending") || ticket.state.include?("In progress")
      else
        flag = false
      end
    end
    flag
  end
end
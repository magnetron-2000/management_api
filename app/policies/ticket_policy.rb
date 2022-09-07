class TicketPolicy < ApplicationPolicy
  def check_developer?
    user.worker.role == "Developer"
  end

  def check_manager?
    user.worker.role == "Manager"
  end
end
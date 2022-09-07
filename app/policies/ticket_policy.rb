class TicketPolicy < ApplicationPolicy
  def check_developer?
    developer?
  end

  def check_manager?
    manager?
  end

  private

  def developer?
    user.worker.role == "Developer"
  end
  def manager?
    user.worker.role == "Manager"
  end
end
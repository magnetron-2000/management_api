class Ticket< ApplicationRecord
  state_machine :state, initial: :backlog do
    event :move_up do # change ticket state for developers
      transition backlog: :pending, pending: :in_progress, in_progress: :waiting_for_accept
    end

    event :to_progress do
      transition declined: :in_progress
    end

    event :decline do  # change ticket state for manager
      transition waiting_for_accept: :declined
    end

    event :accept do
      transition waiting_for_accept: :accepted
    end

    event :finish do
      transition accepted: :done
    end
  end

  belongs_to :worker
  has_many :comments
  validates :title,  length: {maximum: 40}
  validates :worker_id, presence: true

  def mail_after_update(user)
    UserMailer.with(user: self.worker.user, editor: user.worker, old_ticket: self, new_ticket: self).task_changed.deliver_later
  end

  def mail_after_change_worker
    UserMailer.with(user: self.worker.user, ticket: self).assigned_new_task.deliver_later
  end

  def notify_worker
    UserMailer.with(user: self.worker.user, ticket: self).notify_about_state.deliver_later
  end

  def notify_manager
    workers = Worker.where(role: "Manager")
    workers.each {|worker| UserMailer.with(user: worker.user, ticket: self).notify_about_state.deliver_later }
  end
end

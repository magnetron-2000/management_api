class Ticket< ApplicationRecord
  # STATE = ['Backlog', 'Pending', 'In Progress', 'Waiting For Accept', 'Declined', 'Accepted', 'Done']

  state_machine :state, initial: :backlog do
    event :to_pending do
      transition backlog: :pending
    end
  end

  belongs_to :worker
  has_many :comments
  validates :title,  length: {maximum: 40}
  validates :worker_id, presence: true
  validates :state, inclusion: { in: STATE, message: "invalid: state value" }

  def mail_after_update(user)
    UserMailer.with(user: self.worker.user, editor: user.worker, old_ticket: self, new_ticket: self).task_changed.deliver_later
  end

  def mail_after_change_worker
    UserMailer.with(user: self.worker.user, ticket: self).assigned_new_task.deliver_later
  end

  def state_can_be_change_by?(user)
    user.is_admin || user.worker.role == "Manager" || user.worker.id == self.worker_id
  end
end

class Comment < ApplicationRecord
  acts_as_paranoid column: 'deleted', column_type: 'boolean'
  belongs_to :ticket
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment', optional: true
  validates :worker_id, :ticket_id, presence: true
  validates :message,  length: {minimum: 3}
  after_create :send_mail_if_mentioned

  def check_time(hours) # if comment exist too long, user lost possibility delete or change it
    (self.created_at - DateTime.now).abs < hours * 3600
  end

  def mail_after_ping_person
    name = self.message[/(@\w{1,20})|(_\w{1,20})/][1..-1]
    # worker = Worker.where(last_name: name).or(Worker.where(first_name: name)) #TODO where don't work ask mentor
    worker = (Worker.find_by last_name: name) || (Worker.find_by first_name: name)
    UserMailer.with(user: worker.user, comment: self).ping_person.deliver_later if worker && worker.id != self.ticket.creator_worker_id
  end

  def send_mail_if_mentioned
    self.mail_after_ping_person if self.message =~ /(@\w{1,20})|(_\w{1,20})/
  end
end

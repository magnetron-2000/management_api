class Comment < ApplicationRecord
  belongs_to :ticket
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment', optional: true
  validates :worker_id, :ticket_id, presence: true
  validates :message,  length: {minimum: 3}

  def check_time(hours)
    (self.created_at - DateTime.now).abs < hours * 3600
  end
end

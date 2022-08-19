class Comment < ApplicationRecord
  belongs_to :ticket
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment', optional: true
  validates :worker_id, :ticket_id, presence: true
  validates :message,  length: {minimum: 3}
end

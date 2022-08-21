class TicketBlueprint < Blueprinter::Base
  fields :title, :description, :state, :creator_worker_id, :worker_id
  field :created_at, datetime_format:"%d/%m/%Y"
  field :worker_name do |ticket,options|
    " #{ticket.worker.first_name} #{ticket.worker.last_name}"
  end
  field :comment_count do |ticket,options|
    amount = 0
    Comment.all.each do |comment|
      if ticket.id == comment.ticket_id
        amount += 1
      end
    end
    amount
  end
end
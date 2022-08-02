class TicketBlueprint < Blueprinter::Base
  fields :title, :description, :state, :creator_worker_id, :worker_id
  field :created_at, datetime_format:"%d/%m/%Y"
  field :worker_name do |ticket,options|
    " #{ticket.worker.first_name} #{ticket.worker.last_name}"
  end
end
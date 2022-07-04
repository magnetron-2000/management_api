class TicketBlueprint < Blueprinter::Base
  fields :title, :description, :worker_id, :state
end
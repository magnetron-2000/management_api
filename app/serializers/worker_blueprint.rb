class WorkerBlueprint < Blueprinter::Base
  fields :age, :role
  field :name do |worker,options|
    " #{worker.first_name} #{worker.last_name}"
  end

  view :list do
    field :tickets_count do |worker,options|
      amount = 0
      Ticket.all.each do |ticket|
        if worker.id == ticket.worker_id
          amount += 1
        end
      end
      amount
    end
  end

  view :single do
    field :tickets do |worker,options|
      list = []
      Ticket.all.each do |ticket|
        if worker.id == ticket.worker_id
          list << {'title' => ticket.title, 'description' => ticket.description}
        end
      end
      list
    end
  end
end
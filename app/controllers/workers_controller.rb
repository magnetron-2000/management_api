class WorkersController < ApplicationController

  def index
    render json: WorkerBlueprint.render(Worker.all, view: :list)
  end

  def create
    worker = Worker.new(worker_params)
    save(worker)
  end

  def show
    render json:  WorkerBlueprint.render(find, view: :single)
  end

  def update
    worker = find
    worker.update(first_name: params[:first_name],
                  last_name: params[:last_name],
                  age: params[:age],
                  role: params[:role])
    save(worker)
  end

  def destroy
    worker = find
    worker.destroy
    render json: "#{worker.first_name} #{worker.last_name} deleted"
  end

  def activate_worker
    worker = find
    if worker.active
      render json: "#{worker.first_name} #{worker.last_name} already active"
    else
      worker.update(active: true)
      render json: "#{worker.first_name} #{worker.last_name} activated"
    end
  end

  def deactivate_worker
    worker = find
    flag = true
    Ticket.all.each do |ticket|
      if worker.id == ticket.worker_id
        if ticket.state.include?("Pending") || ticket.state.include?("In progress")
          flag = true
        end
      else
        flag = false
      end
    end

    if flag
      render json: "#{worker.first_name} #{worker.last_name} has not finished tickets"
    else
      worker.update_column(:active, false)
      render json: "#{worker.first_name} #{worker.last_name} deactivated"
    end
  end

  private

  def find
    Worker.find(params[:id])
  end

  def worker_params
    params.require(:data).permit(:first_name, :last_name, :age, :role)
  end

  def save(worker)
    if worker.save
      render json: worker, status: :created
    else
      render json: worker.errors, status: :expectation_failed
    end
  end

end

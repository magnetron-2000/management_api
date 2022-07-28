class WorkersController < ApplicationController
  before_action :find, except: [:index, :create]
  before_action :authenticate_user!
  before_action :is_admin?, except: [:index, :show]

  def index
    render json: WorkerBlueprint.render(Worker.all, view: :list)
  end

  # def create
  #   worker = Worker.new(worker_params)
  #   if worker.save
  #     render json: worker, status: :created
  #   else
  #     render json: {errors: [worker.errors.full_messages]}, status: :expectation_failed
  #   end
  # end

  def show
    render json:  WorkerBlueprint.render(@worker, view: :single)
  end

  def update
    if @worker.update(worker_params)
      render json: WorkerBlueprint.render(@worker)
    else
      render json: {errors: [@worker.errors.full_messages]}, status: :bad_request
    end
  end

  def destroy
    @worker.destroy
    render json: ["#{@worker.first_name} #{@worker.last_name} deleted"]
  end

  def activate #TODO  use castom validation validates method
    if @worker.activate!
      @worker.update(active: true)
      render json: ["#{@worker.first_name} #{@worker.last_name} activated"]
    else
      render json: {errors: ["#{@worker.first_name} #{@worker.last_name} already activated"]}
    end
  end

  def deactivate
    if @worker.deactivate!
      render json: ["#{@worker.first_name} #{@worker.last_name} has not finished tickets"]
    else
      @worker.update(active: false)
      render json: ["#{@worker.first_name} #{@worker.last_name} deactivated"]
    end
  end

  private
  def find
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.require(:data).permit(:first_name, :last_name, :age, :role)
  end
end

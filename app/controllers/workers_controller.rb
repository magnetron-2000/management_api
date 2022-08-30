class WorkersController < ApplicationController
  before_action :find, except: [:index, :create]
  before_action :authenticate_user!
  before_action :is_active?
  before_action :is_admin?, only: [:destroy]
  before_action :check_access_worker?, only: [:update, :activate, :deactivate]

  def index
    render json: WorkerBlueprint.render(Worker.all, view: :list)
  end

  def show
    render json:  WorkerBlueprint.render(@worker, view: :single)
  end

  def update
    if is_manager?
      updating(manager_params)
    else
      updating(worker_params)
    end
  end

  def destroy
    @worker.destroy
    render json: ["#{@worker.first_name} #{@worker.last_name} deleted"]
  end

  def activate
    if @worker.activate!
      render json: ["#{@worker.first_name} #{@worker.last_name} activated"]
    else
      render json: {errors: ["#{@worker.first_name} #{@worker.last_name} already activated"]}
    end
  end

  def deactivate
    if @worker.user.is_admin
      render json: {errors: "you can not deactivate admins!"}
    else
      if @worker.deactivate!
        render json: ["#{@worker.first_name} #{@worker.last_name} has not finished tickets"]
      else
        @worker.update(active: false)
        render json: ["#{@worker.first_name} #{@worker.last_name} deactivated"]
      end
    end
  end

  private
  def find
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.require(:data).permit(:first_name, :last_name, :age)
  end

  def manager_params
    params.require(:data).permit(:first_name, :last_name, :age, :role)
  end

  def updating(params)
    if @worker.update(params)
      render json: WorkerBlueprint.render(@worker)
    else
      render json: {errors: [@worker.errors.full_messages]}, status: :bad_request
    end
  end
end

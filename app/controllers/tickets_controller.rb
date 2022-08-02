class TicketsController < ApplicationController
  before_action :find, except: [:index, :create]
  before_action :authenticate_user!
  before_action :is_active?
  before_action :check_access_ticket?, except: [:index, :show, :create, :state]
  def index # list all tickets
    render json: TicketBlueprint.render(Ticket.all)
  end

  def create
    ticket = Ticket.new(create_params)
    ticket.creator_worker_id = current_user.worker.id
    if ticket.save
      render json: ticket, status: :created
    else
      render json: {errors: ticket.errors.full_messages}, status: :expectation_failed
    end
  end

  def show
    render json: TicketBlueprint.render(@ticket)
  end

  def update
    if @ticket.update(update_params)
      render json: TicketBlueprint.render(@ticket)
    else
      render json: {errors: @ticket.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    unless check_is_not_admin_or_manager?
      @ticket.destroy
      render json: "#{@ticket.title} deleted"
    end
  end

  def state # change ticket state
    unless current_user.is_admin || current_user.worker.role == "Manager"
      if current_user.worker.id == @ticket.worker_id
        if @ticket.update(state: params[:state])
          render json: TicketBlueprint.render(@ticket)
        else
          render json: {errors: @ticket.errors.full_messages}
        end
      else
        render json: {message: "you have not access!"}, status: 401
      end
    end
  end

  def change_worker # change ticket worker
    if @ticket.update(worker_id: params[:worker_id])
      render json: TicketBlueprint.render(@ticket)
    else
      render json: {errors: @ticket.errors.full_messages}
    end
  end

  private

  def find
    @ticket = Ticket.find(params[:id])
  end

  def create_params
    params.require(:data).permit(:title, :worker_id, :description, :state)
  end

  def update_params
    params.require(:data).permit(:title, :description)
  end
end

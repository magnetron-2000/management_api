class TicketsController < ApplicationController
  before_action :find, except: [:index, :create]
  before_action :authenticate_user!
  before_action :is_admin?, except: [:index, :show, :create]

  def index # list all tickets
    render json: TicketBlueprint.render(Ticket.all)
  end

  def create
    ticket = Ticket.new(create_params)
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
    @ticket.destroy
    render json: "#{@ticket.title} deleted"
  end

  def state # change ticket state
    if @ticket.update(state: params[:state])
      render json: TicketBlueprint.render(@ticket)
    else
      render json: {errors: @ticket.errors.full_messages}
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

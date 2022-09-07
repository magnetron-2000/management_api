class TicketsController < ApplicationController
  before_action :find, except: [:index, :create]
  before_action :authenticate_user!
  before_action :is_active?
  before_action :check_access_ticket?, except: [:index, :show, :create, :dev_state, :to_progress, :decline, :accept, :done]
  before_action :check_developer, only: [:dev_state, :to_progress]
  before_action :check_manager, only: [:decline, :accept, :done]
  def index
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
      @ticket.mail_after_update current_user
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

  def dev_state # change ticket state for developers
    update_state(@ticket.move_up!) if @ticket.can_move_up?
  end

  def to_progress
    update_state(@ticket.to_progress!) if @ticket.can_to_progress?
  end

  def decline # change ticket state for manager
    update_state(@ticket.decline!) if @ticket.can_decline?
  end

  def accept
    update_state(@ticket.accept!) if @ticket.can_accept?
  end

  def done
    update_state(@ticket.finish!) if @ticket.can_finish?
  end

  def change_worker # change ticket worker
    if @ticket.update(worker_id: params[:worker_id])
      render json: TicketBlueprint.render(@ticket)
      @ticket.mail_after_change_worker
    else
      render json: {errors: @ticket.errors.full_messages}
    end
  end

  private

  def find
    @ticket = Ticket.find(params[:id])
  end

  def create_params
    params.require(:data).permit(:title, :worker_id, :description)
  end

  def update_params
    params.require(:data).permit(:title, :description)
  end

  def update_state(state_method)
    if state_method
      render json: TicketBlueprint.render(@ticket)
    else
      render json: {errors: @ticket.errors.full_messages}
      false
    end
  end

  def check_developer
    unless current_user.worker.role == "Developer"
      no_access
    end
  end

  def check_manager
    return true if current_user.worker.role == "Manager"
    no_access
  end

  def no_access
    render json: {message: "you have not access!"}, status: 401
    false
  end
end

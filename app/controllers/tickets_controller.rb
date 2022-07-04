class TicketsController < ApplicationController


  def index # list all tickets
    render json: TicketBlueprint.render(Ticket.all)
  end

  def create
    ticket = Ticket.new(ticket_params)
    save(ticket)
  end

  def show
    render json: TicketBlueprint.render(Ticket.find(params[:id]))
  end

  def update
    ticket = Ticket.find(params[:id])
    ticket.update(title: params[:title], description: params[:description])
    save(ticket)
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
    render json: "#{ticket.title} deleted"
  end

  def state # change ticket state
    ticket = Ticket.find(params[:id])
    ticket.update(state: params[:state])
    save(ticket)
  end

  def change_worker # change ticket worker
    ticket = Ticket.find(params[:id])
    ticket.update(worker_id: params[:worker_id])
    save(ticket)
  end

  private

    def save(ticket)
      if ticket.save
        render json: ticket, status: :created
      else
        render json: ticket.errors, status: :expectation_failed
      end
    end

    def ticket_params
      params.require(:data).permit(:title, :worker_id, :description, :state)
    end
end

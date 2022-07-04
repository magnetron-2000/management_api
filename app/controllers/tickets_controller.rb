class TicketsController < ApplicationController


  def index
    render json: TicketBlueprint.render(Ticket.all)
  end

  def create
    ticket = Ticket.new(ticket_params)
    if ticket.save
      render json: ticket, status: :created
    else
      render json: ticket.errors, status: :expectation_failed
    end
  end

  def show
    render json: Ticket.find(params[:id])
  end

  def update
    ticket = Ticket.find(params[:id])
    ticket.update(title: params[:title], description: params[:description])
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
    render json: "#{ticket.title} deleted"
  end

  private

  def ticket_params
    params.require(:data).permit(:title, :worker_id, :description, :state)
  end
end

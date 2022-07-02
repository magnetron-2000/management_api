require 'rails_helper'

RSpec.describe TicketsController do
  describe "#index" do
    it 'return a success response' do
      get '/tickets'
      expect(response).to have_http_status(200)
    end

    it 'return valid json' do
      get'/tickets'
      body = JSON.parse(response.body)
      expect(body).to eq(
                        data: {
                          id: ticket.id,
                          type: 'tickets',
                          attributes: {
                            title: ticket.title,
                            description: ticket.description,
                            worker_id: ticket.worker_id,
                            state: ticket.state
                          }
                        }
                      )
    end
  end
end

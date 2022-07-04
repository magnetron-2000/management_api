require 'rails_helper'


RSpec.describe TicketsController do
  describe "#index" do
    let(:worker) {create(:worker)}
    let(:ticket) {create(:ticket, worker:worker)}

    it 'return a success response' do
      get '/tickets'
      expect(response).to have_http_status(200)
    end

    context "when ticket exist" do
      before do
        ticket
      end

      it 'return valid json' do
        get'/tickets'
        body = JSON.parse(response.body)
        expect(body).to eq(
                          [{
                             "title" => ticket.title,
                             "description"=> ticket.description,
                             "worker_id"=> ticket.worker_id,
                             "state"=> ticket.state
                          }]
                        )
      end
    end
  end
end

require 'rails_helper'

RSpec.describe TicketsController do
  describe "tickets controller" do
    HEADERS = { "ACCEPT" => "application/json" }
    let(:worker) {create(:worker)}
    let(:ticket) {create(:ticket, worker:worker)}

    it 'index return a success response' do
      get '/tickets'
      expect(response).to have_http_status(200)
    end

    it 'return a success creating' do
      post "/tickets", :params => { :data => {"title" => ticket.title,
                                              "description"=> ticket.description,
                                              "worker_id"=> ticket.worker_id,
                                              "state"=> ticket.state} }, :headers => HEADERS

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
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
                             "worker_name"=> " #{ticket.worker.first_name} #{ticket.worker.last_name}" ,
                             "state"=> ticket.state,
                             "created_at" => ticket.created_at.strftime("%d/%m/%Y")
                          }]
                        )
      end

      it 'state return state = true' do
        patch '/tickets/1/state'
        expect(response).to have_http_status(200)
      end

      it 'state return state = true' do
        patch '/tickets/1/change_worker'
        expect(response).to have_http_status(200)
      end


      it 'show return a success response' do
        get '/tickets/1'
        expect(response).to have_http_status(200)
      end

      it 'return a success update' do
        patch "/tickets/1", :params => { :data => {"title" => ticket.title,
                                                 "description"=> ticket.description,
                                                 "worker_id"=> ticket.worker_id,
                                                 "state"=> ticket.state} }, :headers => HEADERS

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
      end

      it ' return a success delete' do
      delete '/tickets/1'
      expect(response).to have_http_status(:ok)
      end
    end
  end
end

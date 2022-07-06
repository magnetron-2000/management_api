require 'rails_helper'

RSpec.describe WorkersController do
  describe "worker controller" do
    HEADERS = { "ACCEPT" => "application/json" }
    let(:worker) {create(:worker)}
    let(:ticket) {create(:ticket, worker:worker)}

    def tickets_count(worker)
      amount = 0
      Ticket.all.each do |ticket|
        if worker.id == ticket.worker_id
          amount += 1
        end
      end
      amount
    end

    it 'return a success response index' do
      get '/workers'
      expect(response).to have_http_status(200)
    end

    it 'return a success create' do
      post "/workers", :params => { :data => {"first_name" => worker.first_name,
                                              "last_name"=> worker.last_name,
                                              "age"=> worker.age,
                                              "role"=> worker.role} }, :headers => HEADERS

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
    end

    context "when ticket exist" do
      before do
        worker
      end

      it 'return valid json index' do
        get'/workers'
        body = JSON.parse(response.body)
        expect(body).to eq(
                          [{
                            "name"=> " #{worker.first_name} #{worker.last_name}",
                              "age"=> worker.age,
                              "role"=> worker.role,
                            "tickets_count" => tickets_count(worker)
                          }]
                        )
      end

      it 'return a success response show' do
        get '/workers/1'
        expect(response).to have_http_status(200)
      end

      it 'return a success update' do
        patch "/workers/1", :params => { :data => {"first_name" => worker.first_name,
                                                  "last_name"=> worker.last_name,
                                                  "age"=> worker.age,
                                                  "role"=> worker.role} }, :headers => HEADERS

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
      end

      it 'return active true'do
        patch '/workers/1/activate'
        expect(response).to have_http_status(200)
      end

      it 'return active true'do
        patch '/workers/1/deactivate'
        expect(response).to have_http_status(200)
      end

      it ' return a success delete' do
        delete '/workers/1'
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
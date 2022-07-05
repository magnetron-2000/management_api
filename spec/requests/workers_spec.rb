require 'rails_helper'

RSpec.describe WorkersController do
  describe "#index" do
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

    it 'return a success response' do
      get '/workers'
      expect(response).to have_http_status(200)
    end

    context "when ticket exist" do
      before do
        worker
      end

      it 'return valid json' do
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
    end
  end
end
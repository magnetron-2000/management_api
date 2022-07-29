require 'rails_helper'

RSpec.describe TicketsController do
  describe "tickets controller" do
    HEADERS = { "ACCEPT" => "application/json" }

    let(:ticket) {create(:ticket)}

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

    context "when user is not admin" do
      it "create user and invalid deleting ticket" do # TODO finish ticket test
        post '/users', :params => { "user": {
          "email": "revhttd@mail.com",
          "password": "secret",
          "password_confirmation": "secret",
          "worker_attributes": {
            "first_name": "dfghtr",
            "last_name": "Bradi",
            "age": 30,
            "role": "Developer" } } }

        post "/tickets", :params => { :data => {"title" => ticket.title,
                                                "description"=> ticket.description,
                                                "worker_id"=> ticket.worker_id,
                                                "state"=> ticket.state} }, :headers => HEADERS

        delete '/tickets/1'
          expect(response).to have_http_status(401)
      end
    end
  end
end

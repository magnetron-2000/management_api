require 'rails_helper'

RSpec.describe TicketsController do
  describe "tickets controller" do
    HEADERS = { "ACCEPT" => "application/json" }
    let(:ticket) {create(:ticket)}
    let(:user) {create(:user)}
    let(:params) {
      { "user": {
        "email": "fddsda@mail.com",
        "password": "secret",
        "password_confirmation": "secret",
        "worker_attributes": {
          "first_name": "sdfaw",
          "last_name": "Bradi",
          "age": 30,
          "role": "Manager" } } }
    }

    before do
      post '/users', :params => params

      user = User.last
      user.is_admin = true
      user.save
    end

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
        comment_amount = Comment.all.where(:ticket_id => ticket.id).count
        body = JSON.parse(response.body)
        expect(body).to eq(
                          [{
                             "title" => ticket.title,
                             "description"=> ticket.description,
                             "worker_name"=> " #{ticket.worker.first_name} #{ticket.worker.last_name}" ,
                             "state"=> ticket.state,
                             "created_at" => ticket.created_at.strftime("%d/%m/%Y"),
                             "creator_worker_id" => ticket.creator_worker_id,
                             "worker_id" => ticket.worker_id,
                             "comment_count"=> comment_amount
                          }]
                        )
      end

      it 'state return state = true' do
        patch "/tickets/#{ticket.id}/state"
        expect(response).to have_http_status(200)
      end

      it 'state return state = true' do
        patch "/tickets/#{ticket.id}/change_worker"
        expect(response).to have_http_status(200)
      end


      it 'show return a success response' do
        get "/tickets/#{ticket.id}"
        expect(response).to have_http_status(200)
      end

      it 'return a success update' do
        patch "/tickets/#{ticket.id}", :params => { :data => {"title" => ticket.title,
                                                 "description"=> ticket.description,
                                                 "worker_id"=> ticket.worker_id,
                                                 "state"=> ticket.state} }, :headers => HEADERS

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
      end

      it ' return a success delete' do
      delete "/tickets/#{ticket.id}"
      expect(response).to have_http_status(:ok)
      end
    end
  end
end

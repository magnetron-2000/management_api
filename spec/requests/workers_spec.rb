require 'rails_helper'

RSpec.describe "/workers controller" do
  describe "worker controller" do
    HEADERS = { "ACCEPT" => "application/json" }
    let(:user) {create(:user)}
    let(:params) {
      { "user": {
        "email": "hello@mail.com",
        "password": "secret",
        "password_confirmation": "secret",
        "worker_attributes": {
          "first_name": "hello",
          "last_name": "Bradi",
          "age": 30,
          "role": "Manager" } } }
    }

    before do
      post '/users', :params => params

      user2 = User.last
      user2.is_admin = true
      user2.save
    end

    def tickets_count(worker)
      amount = 0
      Ticket.all.each do |ticket|
        if worker.id == ticket.worker_id
          amount += 1
        end
      end
      amount
    end

    context "when worker exist" do
      it 'return valid json index' do
        get'/workers'
        body = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(body).to eq(
                          [{
                            "name"=> " hello Bradi",
                              "age"=> 30,
                              "role"=> "Manager",
                            "tickets_count" => tickets_count(0)
                          }]
                        )
      end

      it 'return a success response show' do
        get "/workers/#{user.id}"
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body).to eq(
                          {
                             "name"=> " John Doe",
                             "age"=> 30,
                             "role"=> "Manager",
                             "tickets" => []
                           }
                        )
      end

      it 'return a success update' do
        patch "/workers/1", :params => { :data => {"first_name" => "hello",
                                                  "last_name"=> "goodbye",
                                                  "age"=> 30,
                                                  "role"=> "Developer"} }, :headers => HEADERS

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
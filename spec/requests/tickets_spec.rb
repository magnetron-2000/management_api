require 'rails_helper'

RSpec.describe TicketsController do
  describe "tickets controller" do
    HEADERS = { "ACCEPT" => "application/json" }
    let!(:user) {create(:user)}
    let(:worker) {user.worker}
    let!(:ticket) {create(:ticket, worker_id: worker.id)}
    let(:params) {
      { "user": {
        "email": "fddsda@mail.com",
        "password": "secret",
        "password_confirmation": "secret",
        "worker_attributes": {
          "first_name": "sdfaw",
          "last_name": "Bradi",
          "age": 30,
          "role": "Manager" } } } }
    let(:in_params) { { "user": {
      "email": user.email,
      "password": user.password,
      "password_confirmation": user.password_confirmation } } }

    context "user sign up" do
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

        it 'should return 200 when change worker for ticket' do
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
                                                   "worker_id"=> ticket.worker_id, } }, :headers => HEADERS

          expect(response.content_type).to eq("application/json; charset=utf-8")
          expect(response).to have_http_status(:ok)
        end

        it ' return a success delete' do
        delete "/tickets/#{ticket.id}"
        expect(response).to have_http_status(:ok)
        end
      end
    end
    context "state machine tests" do
      context "user sign in" do
        before do # sign in user  for validation
          user.worker.role = "Developer"
          user.save
          post '/users/sign_in', params: in_params # sign in developer
        end

        it 'should have http code 200 for ticket state changing' do
          patch "/tickets/#{ticket.id}/dev_state"
          expect(response).to have_http_status(200)
        end

        it 'should change ticket state to pending' do
          patch "/tickets/#{ticket.id}/dev_state"
          expect(Ticket.first.state).to eq("pending")
        end

        it "should change ticket state to in progress" do
          ticket.state = :declined
          ticket.save
          patch "/tickets/#{ticket.id}/to_progress"
          expect(Ticket.first.state).to eq("in_progress")
        end

        it 'should change ticket state to in progress from declined' do
          ticket.state = :declined
          ticket.save
          patch "/tickets/#{ticket.id}/to_progress"
          expect(Ticket.first.state).to eq("in_progress")
        end
      end
      context "user sign up" do
        before do
          post '/users', :params => params # sign up manager
        end
        context "state = waiting for access" do
          before do
            ticket.state = :waiting_for_accept
            ticket.save
          end
          it "should change ticket state to declined" do
            patch "/tickets/#{ticket.id}/decline"
            expect(Ticket.first.state).to eq("declined")
          end

          it "should change ticket state to accepted" do
            patch "/tickets/#{ticket.id}/accept"
            expect(Ticket.first.state).to eq("accepted")
          end

          it "should change ticket state to done" do
            patch "/tickets/#{ticket.id}/accept"
            patch "/tickets/#{ticket.id}/done"
            expect(Ticket.first.state).to eq("done")
          end
        end
      end
    end
  end
end

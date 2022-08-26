require 'rails_helper'
require './spec/support/helpers'

RSpec.describe "Comments", type: :request do
  describe "GET /index" do
    let!(:user) {create(:user)}
    let(:worker) {user.worker}
    let!(:ticket) {create(:ticket)}
    let!(:comment) {create(:comment)}
    let(:get_request) { get '/tickets/333/comments' }
    let(:params) { {
      "user": {
        "email": "hello@mail.com",
        "password": "secret",
        "password_confirmation": "secret",
        "worker_attributes": {
          "first_name": "dffdfdfdfdfd",
          "last_name": "Bradi",
          "age": 30,
          "role": "Developer" } } }
    }

    before do # sign up user for for validation
      post '/users', params: params
    end
    context "get #index" do
      it "index return a valid http status 200 " do
        get "/tickets/#{ticket.id}/comments"
        expect(response).to have_http_status(200)
      end

      it "index return a valid json " do
        get"/tickets/#{ticket.id}/comments"
        expect(json_body).to eq(
                               [{"message"=> comment.message,
                                 "reply_to_comment_id"=> comment.reply_to_comment_id,
                                 "updated_at"=> comment.updated_at.strftime("%d/%m/%Y"),
                                 "worker_id"=> comment.worker_id}] )
      end

      context "get #index for ticket that does not exist" do
        it "index return a valid http status 200" do
          get_request
          expect(response).to have_http_status(200)
        end

        it "index return a empty json " do
          get_request
          expect(json_body).to eq([])
        end
      end
    end

    context "get #show" do
      it "show return a valid json" do
        get'/tickets/1/comments/1'
        expect(json_body).to eq(
                               {"message"=> comment.message,
                                "reply_to_comment_id"=> comment.reply_to_comment_id,
                                "updated_at"=> comment.updated_at.strftime("%d/%m/%Y"),
                                "worker_id"=> comment.worker_id}
                             )
      end

      it "show return a valid http status 200 " do
        get'/tickets/1/comments/1'
        expect(response).to have_http_status(200)
      end
    end

    context "post #create" do
      it 'return a success creating' do
        post "/tickets/1/comments", :params =>{ data: { message: comment.message } }
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
      end
    end

    context "patch #update" do
      it 'return a success update' do
        patch "/tickets/1/comments/#{comment.id}", :params => { data: { message: "hi" } }
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
        #expect(Comment.find_by(id: comment.id).message).to eq("hi") #TODO ask mentor
      end
    end

    context "delete #destroy" do
      it ' return a success delete' do
        delete "/tickets/1/comments/#{comment.id}"
        expect(response).to have_http_status(:ok)
        #expect(Comment.find_by(id: comment.id).deleted).to eq(true)
      end
    end
  end
end

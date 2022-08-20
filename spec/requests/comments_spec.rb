require 'rails_helper'
require './spec/support/helpers'

RSpec.describe "Comments", type: :request do
  describe "GET /index" do
    HEADERS = { "ACCEPT" => "application/json" }
    let!(:user) {create(:user)}
    let(:worker) {user.worker}
    let!(:ticket) {create(:ticket)}
    let!(:comment) {create(:comment)}
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

    before do
      post '/users', params: params
    end

    it "index return a valid http status 200 " do
      get'/tickets/1/comments'
      expect(response).to have_http_status(200)
    end

    it "index return a valid http status 200" do
      get'/tickets/333/comments'
      expect(response).to have_http_status(200)
    end

    it "index return a valid json " do
      get'/tickets/1/comments'
      expect(json_body).to eq(
                        [{"message"=> comment.message,
                          "reply_to_comment_id"=> comment.reply_to_comment_id,
                          "updated_at"=> comment.updated_at.strftime("%d/%m/%Y"),
                          "worker_id"=> comment.worker_id}]
                      )
    end

    it "index return a valid json " do
      get'/tickets/1111/comments'
      expect(json_body).to eq([])
    end

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

    it 'return a success creating' do
      post "/tickets/1/comments", :params =>{ data: {
                                              message: comment.message } }, :headers => HEADERS
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
    end
  end
end

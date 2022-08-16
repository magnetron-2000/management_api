require 'rails_helper'

RSpec.describe '/session controllers' do
  describe "#create" do
    context 'post request sign in' do
      it 'should return 200 http status code if user sign in' do
        post '/users/sign_in', :params => { "user": {
                                            "email": "dfdsddsfd@mail.com",
                                            "password": "secret",
                                            "password_confirmation": "secret" }}
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "#delete" do
    context "delete request sign out after sign up" do
      it 'should return 200 http status code if user sign out' do
        post '/users', :params => { "user": {
          "email": "some@mail.com",
          "password": "secret",
          "password_confirmation": "secret",
          "worker_attributes": {
            "first_name": "hi",
            "last_name": "Bradi",
            "age": 30,
            "role": "Developer" } } }
        delete '/users/sign_out'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"message"=>"You are signed out."})
      end
    end
  end
end
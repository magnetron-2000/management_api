require 'rails_helper'

RSpec.describe '/session controllers' do
  describe "#create" do
    context 'post request sign in' do
      let!(:user) {create(:user)}
      let(:params_in) {{ "user": {
        "email": "person1@mail.com",
        "password": "secret",
        "password_confirmation": "secret" }}}


      it 'should return valid message if user sign in' do
        post '/users/sign_in', :params => params_in
        expect(JSON.parse(response.body)["message"]).to eq("You are logged in.")
      end


      it 'should return 200 http status code if user sign in' do
        post '/users/sign_in', :params => params_in
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "#delete" do
    context "delete request sign out after sign up" do
      let(:params_up) {
        { "user": {
          "email": "some@mail.com",
          "password": "secret",
          "password_confirmation": "secret",
          "worker_attributes": {
            "first_name": "hi",
            "last_name": "Bradi",
            "age": 30,
            "role": "Developer" } } }
      }

      it 'should return 200 http status code if user sign out' do
        post '/users', :params => params_up
        delete '/users/sign_out'
        expect(response).to have_http_status(:ok)
      end

      it 'should return message if user sign out' do
        post '/users', :params => params_up
        delete '/users/sign_out'
        expect(JSON.parse(response.body)).to eq({"message"=>"You are signed out."})
      end
    end
  end
end
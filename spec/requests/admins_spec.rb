require 'rails_helper'

RSpec.describe '/admins controllers' do
  describe "#add_to_admins, remove_from_admins" do
    context 'add_to_admins and remove from admins' do

      before do
        post '/users', :params => { "user": {
          "email": "dfddfdfddsfd@mail.com",
          "password": "secret",
          "password_confirmation": "secret",
          "worker_attributes": {
            "first_name": "dffdfdfdfdfd",
            "last_name": "Bradi",
            "age": 30,
            "role": "Manager" } } }
        delete '/users/sign_out'

        post '/users', :params => { "user": {
          "email": "fddsda@mail.com",
          "password": "secret",
          "password_confirmation": "secret",
          "worker_attributes": {
            "first_name": "sdfaw",
            "last_name": "Bradi",
            "age": 30,
            "role": "Manager" } } }

        user = User.last
        user.is_admin = true
        user.save
      end

      it 'should return 200 http status code if user become admin' do
        patch '/add_admin/1'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"message"=>"dfddfdfddsfd@mail.com is admin"})
      end

      it 'should return 200 if user lost admin status' do
        patch '/add_admin/1'
        patch '/remove_admin/1'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"message"=>"dfddfdfddsfd@mail.com is not admin"})
      end
    end
  end
end
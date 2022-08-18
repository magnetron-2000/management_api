require 'rails_helper'
require './spec/support/helpers'

RSpec.describe '/admins controllers' do
  describe "#add_to_admins, remove_from_admins" do
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
    context 'add_to_admins and remove from admins' do

      before do
        post '/users', :params => params

        user2 = User.last
        user2.is_admin = true
        user2.save
      end

      it 'should return 200 http status code if user become admin and message "user is admin"' do
        patch "/add_admin/#{user.id}"
        expect(response).to have_http_status(:ok)
        expect(json_body).to eq({"message"=>"#{user.email} is admin"})
      end

      it 'should return 200 http status code if user already is admin and error "already admin!"' do
        patch "/add_admin/#{user.id}"
        patch "/add_admin/#{user.id}"
        expect(response).to have_http_status(:ok)
        expect(json_body).to eq({"errors"=>"already admin!"})
      end

      it 'should return 200 if user lost admin status and message "user is not admin"' do
        patch "/add_admin/#{user.id}"
        patch "/remove_admin/#{user.id}"
        expect(response).to have_http_status(:ok)
        expect(json_body).to eq({"message"=>"#{user.email} is not admin"})
      end

      it 'should return 200 if user lost admin status and message "already not an admin!"' do
        patch "/add_admin/#{user.id}"
        patch "/remove_admin/#{user.id}"
        patch "/remove_admin/#{user.id}"
        expect(response).to have_http_status(:ok)
        expect(json_body).to eq({"errors"=>"already not an admin!"})
      end
    end
  end
end
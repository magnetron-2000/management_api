require 'rails_helper'

RSpec.describe '/admins controllers' do
  describe "#add_to_admins, remove_from_admins" do
    context 'patch add_to_admins' do

      before(:each) do
          post '/users/sign_in', :params => { "user": {
              "email": "dfdsddsfd@mail.com",
              "password": "secret",
              "password_confirmation": "secret" } }
      end

      it 'should return 200 http status code' do
        expect(response).to have_http_status(:ok)
      end

      it '' do
        patch '/users/add_admin/1'
        expect(User.find_by(id: 2)).is_admin.to eq(true)
      end
    end
  end
end
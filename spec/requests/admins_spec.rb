require 'rails_helper'

RSpec.describe '/admins controllers' do
  describe "#add_to_admins, remove_from_admins" do
    context 'patch add_to_admins' do
      before(:each) do
        post '/users/sign_in', :params => {
          "email" => "asdfdf@mail.com",
          "password"=> "secret",
          "password_confirmation"=> "secret"
        }
      end

      it 'should return 200 http status code' do
        patch '/add_admin/2'
        expect(response).to have_http_status(:ok)
      end

      it 'is admin true' do
        patch '/add_admin/2'
        expect(User.find_by(id: 2)).is_admin.to eq(true)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe '/session controllers' do
  describe "#create, delete" do
    context 'post request sign in' do

      let(:user) {create :user}

      before(:each) do
        post '/users/sign_in', :params => {
               "email" => user.email,
               "password"=> user.encrypted_password,
               "password_confirmation"=> user.encrypted_password
             }
      end

      it 'should return 200 http status code' do
        expect(response).to have_http_status(:ok)
      end

      # it 'should return 200 http status code' do
      #   delete '/users/sign_out'
      #   expect(response).to have_http_status(:ok)
      # end
    end
  end
end
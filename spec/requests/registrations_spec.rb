require 'rails_helper'

RSpec.describe '/registration controllers' do
  describe "#create" do
    context 'when user exist' do
      let(:user) {create :user}

      it 'should return 201 http status code' do
        post '/users', :params => {  "email" => user.email,
                                     "password"=> user.encrypted_password,
                                     "password_confirmation"=> user.encrypted_password}
        expect(response).to have_http_status(:ok)
      end

      it 'should create a user' do
        expect(User.exists?(email: 'third@mail.com')).to be_falsey
        expect{ user }.to change{ User.count }.by(1)
        expect(User.exists?(email: 'third@mail.com')).to be_truthy
      end

    end

    context 'when user not exist' do
      let(:user) do
        {
            "email": nil,
            "password": nil,
            "password_confirmation": nil
        }
      end

      it 'should not create a user' do
        expect{ user }.not_to change{ User.count }
      end
    end
  end
end
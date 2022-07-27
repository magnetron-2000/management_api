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

      context "when user and worker exist" do
        user = {
            "email": "dfddfdfddsfd@mail.com",
            "password": "secret",
            "password_confirmation": "secret",
            "worker_attributes": {
              "first_name": "dffdfdfdfdfd",
              "last_name": "Bradi",
              "age": 30,
              "role": "Developer" } }

        it 'should return true' do
          post '/users', :params => {  "email" => user.email,
                                       "password"=> user.encrypted_password,
                                       "password_confirmation"=> user.encrypted_password,
                                       "worker_attributes" => {"first_name" => user.first_name,
                                                               "last_name" => user.last_name,
                                                               "age" => user.age,
                                                               "role" => user.role,
                                                               "active" => user.active} }
          expect{ user }.to change{ User.count }.by(1).and change{ Worker.count }.by(1)
        end
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
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
        context 'when user and worker valid' do
          it 'should return true' do
            expect do
            post '/users', :params => { "user": {
                                      "email": "dfddfdfddsfd@mail.com",
                                      "password": "secret",
                                      "password_confirmation": "secret",
                                      "worker_attributes": {
                                        "first_name": "dffdfdfdfdfd",
                                        "last_name": "Bradi",
                                        "age": 30,
                                        "role": "Developer" } } }
            end.to change{User.count}.by(1)
            expect(JSON.parse(response.body)['worker']).to be_present
            expect(JSON.parse(response.body)['worker']['user_id']).to eq(JSON.parse(response.body)['user']['id'])
          end
          context 'when params invalid' do
            it 'should not create a user (invalid user params)' do
              expect do
                post '/users', :params => { "user": {
                  "email": "",
                  "password": "secret",
                  "password_confirmation": "secret",
                  "worker_attributes": {
                    "first_name": "dffdfdfdfdfd",
                    "last_name": "Bradi",
                    "age": 30,
                    "role": "Developer" } } }
              end.to change{User.count}.by(1)
            end
            it 'should not create a user (invalid worker params)' do
              expect do
                post '/users', :params => { "user": {
                  "email": "dfddfdfddsfd@mail.com",
                  "password": "secret",
                  "password_confirmation": "secret",
                  "worker_attributes": {
                    "first_name": "",
                    "last_name": "",
                    "age": 30,
                    "role": "Developer" } } }
              end.to change{User.count}.by(1)
            end
          end
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
require 'rails_helper'

RSpec.describe '/registration controllers' do
  describe "#create" do
    context 'when user exist' do
      let(:user) {build(:user)}
      it 'should return 201 http status code' do
        post '/users', :params => { "user": {
                                    "email": "hello@mail.com",
                                    "password": "secret",
                                    "password_confirmation": "secret",
                                    "worker_attributes": {
                                      "first_name": "dffdfdfdfdfd",
                                      "last_name": "Bradi",
                                      "age": 30,
                                      "role": "Developer" } } }
        expect(response).to have_http_status(:ok)
        expect(User.exists?(email: 'third@mail.com')).to be_falsey
        expect(User.exists?(email: 'hello@mail.com')).to be_truthy
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

      it 'should show error' do
        post '/users', :params => { "user": {
          "email": "",
          "password": "secret",
          "password_confirmation": "secret",
          "worker_attributes": {
            "first_name": "hi",
            "last_name": "Bradi",
            "age": 30,
            "role": "Developer" } } }
        expect(JSON.parse(response.body)["errors"]).to eq(["Email can't be blank"])
      end
    end
  end
end
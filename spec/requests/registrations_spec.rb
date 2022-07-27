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

      context 'create with worker' do
        context 'when worker params valid' do
          it 'should create user and worker' do
            expect do
              post '/users', :params => {
                user: {
                  "email"                 => 'test@test.com',
                  "password"              => 12342,
                  "password_confirmation" => 12342,
                },
                worker:{
                  last_name:  'a',
                  first_name: 'v',
                  age:        20,
                  role:       'Developer',
                  active:     true
                }
              }
            end.to change{ User.count }.by(1)
            expect(JSON.parse(response.body)['worker']).to be_present
            expect(JSON.parse(response.body)['worker']['user_id']).to eq(JSON.parse(response.body)['user']['id'])
          end
        end

        context 'when worker params invalid' do
          it 'should not create user and worker' do
            expect do
              post '/users', :params => {
                user: {
                  "email"                 => 'test@test.com',
                  "password"              => 12342,
                  "password_confirmation" => 12342,
                },
                worker:      {
                  last_name:  'a',
                  first_name: 'v',
                  age:        0,
                  role:       'Lol',
                  active:     true
                }
              }
            end.to change{ User.count }.by(0).and change{ Worker.count }.by(0)
            response
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
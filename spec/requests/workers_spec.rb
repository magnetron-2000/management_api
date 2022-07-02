require 'rails_helper'

RSpec.describe WorkersController do
  describe "#index" do
    it 'return a success response' do
      get '/workers'
      expect(response).to have_http_status(200)
    end

    it 'return valid json' do
      get'/workers'
      body = JSON.parse(response.body)
      expect(body).to eq(
                        data: {
                          id: worker.id,
                          type: 'workers',
                          attributes: {
                            last_name: worker.last_name,
                            first_name: worker.first_name,
                            age: worker.age,
                            role: worker.role,
                            active: worker.active
                          }
                        }
                      )
    end
  end
end
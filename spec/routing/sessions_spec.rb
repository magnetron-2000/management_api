require 'rails_helper'

RSpec.describe '/session routes' do
  describe "#route" do
    it 'to user#sign_in' do
      expect(post '/users/sign_in').to route_to('users/sessions#create')
    end

    it 'to user#sign_out' do
      expect(delete '/users/sign_out').to route_to('users/sessions#destroy')
    end
  end
end
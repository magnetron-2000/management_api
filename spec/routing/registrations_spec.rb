require 'rails_helper'

RSpec.describe '/registration routes' do
  describe "#route" do
    it 'to registration#create' do
      expect(post '/sign_up').to route_to('users/registrations#create')
    end
  end
end
require 'rails_helper'

RSpec.describe '/workers routes' do
  describe "#route" do

    it "to workers#index" do
      expect(get '/workers').to route_to('workers#index')
    end

    it "to workers#show" do
      expect(get '/workers/1').to route_to(controller: 'workers',
                                           action: 'show',
                                           id: "1")
    end

    it "to workers#create" do
      expect(post '/workers').to route_to('workers#create')
    end

    it "to workers#update" do
      expect(patch '/workers/1').to route_to(controller: 'workers',
                                             action: 'update',
                                             id: "1")
    end

    it "to workers#destroy" do
      expect(delete '/workers/1').to route_to(controller: 'workers',
                                              action: 'destroy',
                                              id: "1")
    end
  end
end
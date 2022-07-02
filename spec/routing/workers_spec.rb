require 'rails_helper'

RSpec.describe '/workers routes' do
  describe "#route" do

    it "to workers#index" do
      expect(get '/workers').to route_to('workers#index')
      #expect(get '/ticket?page[number]=3').to route_to('article#index', page {'number' => 3})
    end

    it "to workers#show" do
      expect(get '/workers/1').to route_to('workers#show')
    end

    it "to workers#new" do
      expect(get '/workers/new').to route_to('workers#new')
    end

    it "to workers#create" do
      expect(post '/workers').to route_to('workers#create')
    end

    it "to workers#edit" do
      expect(get '/workers/1/edit').to route_to('workers#edit')
    end

    it "to workers#update" do
      expect(patch '/workers/1').to route_to('workers#update')
    end

    it "to workers#destroy" do
      expect(delete '/workers/1').to route_to('workers#destroy')
    end
  end
end
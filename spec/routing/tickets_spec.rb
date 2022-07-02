require 'rails_helper'

RSpec.describe '/tickets routes' do
  describe "#route" do

    it "to ticket#index" do
      expect(get '/tickets').to route_to('tickets#index')
      #expect(get '/ticket?page[number]=3').to route_to('article#index', page {'number' => 3})
    end

    it "to ticket#show" do
      expect(get '/tickets/1').to route_to('tickets#show')
    end

    it "to tickets#new" do
      expect(get '/tickets/new').to route_to('tickets#new')
    end

    it "to tickets#create" do
      expect(post '/tickets').to route_to('tickets#create')
    end

    it "to tickets#edit" do
      expect(get '/tickets/1/edit').to route_to('tickets#edit')
    end

    it "to tickets#update" do
      expect(patch '/tickets/1').to route_to('tickets#update')
    end

    it "to tickets#destroy" do
      expect(delete '/tickets/1').to route_to('tickets#destroy')
    end
  end
end
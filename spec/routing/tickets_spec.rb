require 'rails_helper'

RSpec.describe '/tickets routes' do
  describe "#route" do

    it "to ticket#index" do
      expect(get '/tickets').to route_to('tickets#index')
    end

    it "to ticket#show" do
      expect(get '/tickets/1').to route_to(controller: 'tickets',
                                           action: 'show',
                                           id: "1")
    end

    it "to tickets#create" do
      expect(post '/tickets').to route_to('tickets#create')
    end

    it "to tickets#update" do
      expect(patch '/tickets/1').to route_to(controller: 'tickets',
                                             action: 'update',
                                             id: "1")
    end

    it "to tickets#destroy" do
      expect(delete '/tickets/1').to route_to(controller: 'tickets',
                                              action: 'destroy',
                                              id: "1")
    end

    it "to tickets#state" do
      expect(patch '/tickets/1/state').to route_to(controller: 'tickets',
                                                   action: 'state',
                                                   id: "1")
    end

    it "to tickets#change_worker" do
      expect(patch '/tickets/1/change_worker').to route_to(controller: 'tickets',
                                                   action: 'change_worker',
                                                   id: "1")
    end
  end
end
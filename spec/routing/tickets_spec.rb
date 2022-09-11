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

    it "to tickets#dev_state" do
      expect(patch '/tickets/1/dev_state').to route_to(controller: 'tickets',
                                                   action: 'dev_state',
                                                   id: "1")
    end

    it "to tickets#to_progress" do
      expect(patch '/tickets/1/to_progress').to route_to(controller: 'tickets',
                                                       action: 'to_progress',
                                                       id: "1")
    end

    it "to tickets#decline" do
      expect(patch '/tickets/1/decline').to route_to(controller: 'tickets',
                                                       action: 'decline',
                                                       id: "1")
    end

    it "to tickets#accept" do
      expect(patch '/tickets/1/accept').to route_to(controller: 'tickets',
                                                       action: 'accept',
                                                       id: "1")
    end

    it "to tickets#done" do
      expect(patch '/tickets/1/done').to route_to(controller: 'tickets',
                                                       action: 'done',
                                                       id: "1")
    end

    it "to tickets#change_worker" do
      expect(patch '/tickets/1/change_worker').to route_to(controller: 'tickets',
                                                   action: 'change_worker',
                                                   id: "1")
    end
  end
end
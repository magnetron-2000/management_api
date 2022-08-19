require 'rails_helper'

RSpec.describe "Comments" do
  describe "route" do
    it "to comment#index" do
      expect(get '/tickets/1/comments').to route_to(controller: 'comments',
                                                    ticket_id: "1",
                                                    action: 'index')
    end

    it "to comment#show" do
      expect(get '/tickets/1/comments/1').to route_to(controller: 'comments',
                                                      ticket_id: "1",
                                                      action: 'show',
                                                      id: "1")
    end

    it "to comment#create" do
      expect(post '/tickets/1/comments').to route_to(controller: 'comments',
                                                     ticket_id: "1",
                                                     action: 'create')
    end
  end
end

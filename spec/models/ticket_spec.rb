require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "#validations" do
    let(:worker) {build(:worker)}
    let(:ticket) {build(:ticket)}

    it "worker_id eq 1" do
      expect(ticket.worker_id).to eq(1)
    end

    it "worker_id invalid" do
      ticket.worker_id = nil
      expect(ticket).not_to be_valid
      expect(ticket.errors.messages).to match_array({:worker=>["must exist"], :worker_id=>["can't be blank"]})
    end

    it "title eq string" do
      expect(ticket.title).to eq('string')
    end

    it "title is more then 40 s" do
      ticket.title = "a" * 44
      expect(ticket).not_to be_valid
    end

    it "description eq new string" do
      expect(ticket.description).to eq('new string')
    end

    it "state eq Pending" do
      expect(ticket.state).to eq('Pending')
    end

    it "state validation" do
      ticket.state = " "
      expect(ticket).not_to be_valid
    end

  end
end

require 'rails_helper'

RSpec.describe Ticket, type: :model do #  TODO tests for activate and deactivate
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

    it "title is more then 40 s" do
      ticket.title = "a" * 44
      expect(ticket).not_to be_valid
    end

    it "state validation" do
      ticket.state = " "
      expect(ticket).not_to be_valid
    end

  end
end

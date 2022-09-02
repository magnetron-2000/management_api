require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "#validations" do
    let(:user) {create(:user)}
    let(:worker) {user.worker}
    let(:ticket) {create(:ticket, worker_id: worker.id)}

    it "title is more then 40 s" do
      ticket.title = "a" * 44
      expect(ticket).not_to be_valid
    end

    it "worker_id invalid" do
      ticket.worker_id = nil
      expect(ticket).not_to be_valid
      expect(ticket.errors.messages).to match_array({:worker=>["must exist"], :worker_id=>["can't be blank"]})
    end

    it "state validation" do
      ticket.state = " "
      expect(ticket).not_to be_valid
    end


    context "state machine" do
      it { is_expected.to handle_events :move_up, when: :backlog }
      it { is_expected.to handle_events :move_up, when: :pending }
      it { is_expected.to handle_events :move_up, when: :in_progress }
      it { is_expected.to handle_events :decline, when: :waiting_for_accept }
      it { is_expected.to handle_events :accept, when: :waiting_for_accept }
      it { is_expected.to handle_events :to_progress, when: :declined }
      it { is_expected.to handle_events :finish, when: :accepted }
      it { is_expected.to reject_events :finish, when: :done }
    end
  end
end

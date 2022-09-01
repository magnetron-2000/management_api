require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "#validations" do
    let(:user) {build(:user)}
    let(:worker) {user.worker}
    let(:ticket) {build(:ticket)}

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

    it "should have one worker" do
      t = Ticket.reflect_on_association(:worker)
      expect(t.macro).to eq(:belongs_to)
    end

    context "state machine" do
      it { is_expected.to handle_events :move_up, when: :backlog }
      it { is_expected.to handle_events :move_up, when: :pending }
      it { is_expected.to handle_events :move_up, when: :in_progress }
      it { is_expected.to handle_events :decline, when: :waiting_for_accept }
      it { is_expected.to handle_events :accept, when: :waiting_for_accept }
      it { is_expected.to handle_events :processing, when: :declined }
      it { is_expected.to handle_events :finish, when: :accepted }
      it { is_expected.to reject_events :finish, when: :done }
    end
  end
end

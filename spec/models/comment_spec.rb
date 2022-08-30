require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    let!(:user) {create(:user)}
    let(:worker) {user.worker}
    let!(:ticket) {create(:ticket)}
    let!(:comment) {create(:comment, worker_id: worker.id, ticket_id: ticket.id)}


    it "create a comment" do
      expect(comment).to be_valid
    end

    it "is not valid without a message" do
      comment.message = nil
      expect(comment).to_not be_valid
    end

    it "is not valid without a message" do
      comment.worker_id = nil
      expect(comment).to_not be_valid
    end

    it "is not valid without a message" do
      comment.ticket_id = nil
      expect(comment).to_not be_valid
    end

    context "check time" do
      context "if hours more time existing comment" do
        it "should return true " do
          expect(comment.check_time(1)).to be_truthy
        end
      end
      context "if hours less time existing comment" do
        it "should return false " do
          expect(comment.check_time(0.0000001)).to be_falsey
        end
      end
    end

    context 'check parents' do
      let!(:parent_comment) {create(:comment, worker_id: worker.id, ticket_id: ticket.id)}
      let(:child_comment) { create(:comment, worker_id: worker.id, ticket_id: ticket.id, reply_to_comment_id: parent_comment.id)}

      it 'should match parent and children' do
        expect(Comment.find_by(id: parent_comment.id).id).to eq(Comment.find_by(id: child_comment.id).reply_to_comment_id)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    let!(:user) {create(:user)}
    let(:worker) {user.worker}
    let!(:ticket) {create(:ticket)}
    let!(:comment) {create(:comment)}

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

    it "should have one ticket" do
      t = Comment.reflect_on_association(:ticket)
      expect(t.macro).to eq(:belongs_to)
    end#TODO how to test self join table
  end
end

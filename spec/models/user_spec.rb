require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    let(:user) {build :user}

    it "email validation" do
      expect(user).to be_valid
    end
  end
end

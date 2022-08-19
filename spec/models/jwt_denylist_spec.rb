require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  describe "#validations" do
    let(:jwt_denylist) {build(:jwt_denylist)}

    it "should exist" do
      expect(jwt_denylist).to be_present
    end

  end
end

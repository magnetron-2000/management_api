require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    let(:user) {build :user}

    it "should exist" do
      expect(user).to be_present
    end

    it "should exist worker" do
      expect(user.worker).to be_present
    end

    it "should have one worker" do
      t = User.reflect_on_association(:worker)
      expect(t.macro).to eq(:has_one)
    end

    it "check_admin should return false" do
    expect(user.check_admin).to eq(false)
    end

    it "user should become an admin" do
      user.adding
      expect(user.is_admin).to eq(true)
    end

    it "user should lose admin status" do
      user.removing
      expect(user.is_admin).to eq(false)
    end

    it "should save new user email" do
      user.email = "somethingnew@mail.com"
      user.save
      expect(user.email).to eq("somethingnew@mail.com")
    end

    it "user is not a manager" do
      p user.worker.first_name
      expect(user.check_manager).to eq(true)
    end
  end
end

require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe "#validations" do
    let(:worker) {build(:worker)}

    it "last name eq to string" do
      expect(worker.last_name).to eq("Doe")
    end

    it "invalid test, last name more then 20 s" do
      worker.last_name = 'a' * 22
      expect(worker).not_to be_valid
    end

    it "first name eq to string" do
      expect(worker.first_name).to eq("John")
    end

    it "invalid test, first name more then 20 s" do
      worker.first_name = 'a' * 22
      expect(worker).not_to be_valid
    end

    it "age eq to 30" do
      expect(worker.age).to eq(30)
    end

    it 'role eq to Manager' do
      expect(worker.role).to eq("Manager")
    end

    it 'invalid test, role is not valid' do
      worker.role = 'something'
      expect(worker).not_to be_valid
    end

    it "active is true" do
      expect(worker.active).to eq(true)
    end

    it 'invalid test, active is not true' do
      worker.active = nil
      expect(worker).not_to be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe "#validations" do
    let(:worker) {build(:worker)}

    it "invalid test, last name more then 20 s" do
      worker.last_name = 'a' * 22
      expect(worker).not_to be_valid
    end

    it "invalid test, first name more then 20 s" do
      worker.first_name = 'a' * 22
      expect(worker).not_to be_valid
    end

    it 'invalid test, age is not in range 16..60' do
      worker.age = 5
      expect(worker).not_to be_valid
    end

    it 'invalid test, role is not valid' do
      worker.role = 'something'
      expect(worker).not_to be_valid
    end

    it 'invalid test, active is not true' do
      worker.active = nil
      expect(worker).not_to be_valid
    end

    it 'activate! return false' do
      expect(worker.activate!).to eq(false)
    end

    it 'deactivate! return false' do
      expect(worker.deactivate!).to eq(true)
    end
  end
end

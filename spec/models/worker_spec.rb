require 'rails_helper'

RSpec.describe Worker, type: :model do
  it "eq to string" do
  worker = create(:worker)
  expect(worker.last_name).to eq("Doe")
  end
end

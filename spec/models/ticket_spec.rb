require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "eq to string" do
    worker = create(:worker)
    ticket = create(:ticket)
    expect(ticket.title).to eq("string")
  end
end



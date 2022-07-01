require 'rails_helper'

RSpec.describe Ticket, type: :model do
  ticket = create(:ticket)
  expect(ticket.title).to eq("string")
end



require 'rails_helper'

RSpec.describe '/admins routes' do
  describe "#route" do
    it 'to users/admins#add_to_admins' do
      expect(patch '/users/add_admin/1').to route_to(controller: 'users/admins',
                                           action: 'add_to_admins',
                                           id: "1")
    end

    it 'to users/admins#remove_from_admins' do
      expect(patch '/users/remove_admin/1').to route_to(controller: 'users/admins',
                                               action: 'remove_from_admins',
                                               id: "1")
    end
  end
end
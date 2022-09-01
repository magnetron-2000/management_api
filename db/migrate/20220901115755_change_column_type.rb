class ChangeColumnType < ActiveRecord::Migration[6.0]
  change_column(:tickets, :state, :string)
end

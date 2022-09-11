class ChangeDefaultState < ActiveRecord::Migration[6.0]
  change_column_default(
    :tickets,
    :state,
    from: nil,
    to: "Backlog"
  )
end

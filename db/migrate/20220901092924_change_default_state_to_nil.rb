class ChangeDefaultStateToNil < ActiveRecord::Migration[6.0]
  change_column_default(
    :tickets,
    :state,
    from: "Backlog",
    to: nil
  )
end

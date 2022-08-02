class ChangeIsAdminDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default(
      :users,
      :is_admin,
      from: nil,
      to: false
    )
  end
end

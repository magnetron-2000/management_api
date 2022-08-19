class ToDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default(
      :comments,
      :deleted,
      from: nil,
      to: false
    )
    change_column_default(
      :comments,
      :parent_id,
      from: nil,
      to: false
    )
  end
end
class AddIndexesToComment < ActiveRecord::Migration[6.0]
  def change
    add_index :comments, :ticket_id
    add_index :comments, :worker_id

  end
end

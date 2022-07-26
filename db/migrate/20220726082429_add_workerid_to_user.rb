class AddWorkeridToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :worker_id, :integer
  end
end

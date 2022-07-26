class AddUserIdToWorker < ActiveRecord::Migration[6.0]
  def change
    add_reference :workers, :user, foreign_key: true
  end
end

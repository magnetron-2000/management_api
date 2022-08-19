class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :worker_id
      t.integer :ticket_id
      t.integer :reply_to_comment_id
      t.boolean :deleted
      t.timestamps
    end
  end
end

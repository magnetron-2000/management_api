class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :worker_id
      t.text :state
    end
  end
end

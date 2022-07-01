class CreateWorkers < ActiveRecord::Migration[6.0]
  def change
    create_table :workers do |t|
      t.string :last_name
      t.string :first_name
      t.integer :age
      t.text :role
      t.boolean :active, default: true
    end
  end
end

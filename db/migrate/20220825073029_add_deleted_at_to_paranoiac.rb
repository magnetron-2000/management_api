class AddDeletedAtToParanoiac < ActiveRecord::Migration[6.0]
  def change
    add_index :comments, :deleted
  end
end

class AddTwitterId < ActiveRecord::Migration
  def change
    add_column :entities, :twitter_id, :bigint, :null => true
    add_column :friends, :twitter_id, :bigint, :null => true
    remove_column :friends, :twitter_handle
  end
end

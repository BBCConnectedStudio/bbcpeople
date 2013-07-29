class AddFriends < ActiveRecord::Migration
  def up
    create_table(:friends) do |t|
      t.integer :user_id
      t.string  :twitter_handle,  :null => false, :default => ""
      t.timestamps
    end

    remove_column :users, :user_id
  end

  def down
    add_column :users, :user_id, :string
    drop_table :friends
  end
end

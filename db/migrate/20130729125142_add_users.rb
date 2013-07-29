class AddUsers < ActiveRecord::Migration
  def up
    create_table(:users) do |t|
      t.integer :user_id
      t.string  :twitter_handle,  :null => false, :default => ""
      t.string  :provider,  :null => false, :default => ""
      t.string  :uid,       :null => false, :default => ""
      t.string  :token
      t.string  :secret

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end

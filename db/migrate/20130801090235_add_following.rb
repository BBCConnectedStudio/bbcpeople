class AddFollowing < ActiveRecord::Migration
  def up
    create_table :followings do |table|
      table.integer  :user_id
      table.string   :dbpedia_key
      table.timestamps
    end

    add_index :followings, [:user_id, :dbpedia_key]
  end

  def self.down
    drop_table :followings
  end
end

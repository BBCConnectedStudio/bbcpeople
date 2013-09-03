class AddMpColumns < ActiveRecord::Migration
  def change
    add_column :entities, :twfy_uri, :string
    add_column :entities, :parliament_uri, :string
    change_column :entities, :created_at, :datetime, :null => true
    change_column :entities, :updated_at, :datetime, :null => true
  end
end

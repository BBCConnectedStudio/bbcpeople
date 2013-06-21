class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.string :name
      t.text :description
      t.string :dbpedia_uri
      t.string :image_uri
      t.string :xpedia_slug
      t.string :twitter_handle
      t.string :type
      t.integer :cooccurence_count, :default => 0
      t.timestamps
    end

    create_table :articles do |t|
      t.string :cps_id
      t.string :headline
      t.string :uri
      t.datetime :published_at
      t.timestamps
    end

    create_table :programmes do |t|
      t.string :pid
      t.string :title
      t.string :subtitle
      t.text :synopsis
      t.timestamps
    end

  end

  def self.down
    drop_table :entities
    drop_table :articles
    drop_table :programmes
  end
end

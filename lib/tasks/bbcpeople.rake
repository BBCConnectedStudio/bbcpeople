namespace :bbcpeople do
  desc "Imports all the MP data into the database"
  task :import_mps => :environment do
    sql = File.open("#{Rails.root}/db/mps.sql", "r").read

    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection.execute(sql)

    puts 'Import completed.'
  end

  task :twitter_id_import => :environment do
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_SECRET']
    end
    entity = Entity.where("entities.twitter_handle IS NOT NULL AND entities.twitter_id IS NULL").first
    entity = Entity.fetch_by_dbpedia_key(entity.xpedia_slug)
    twitter_user = Twitter.user(entity.twitter_handle)
    entity.twitter_id = twitter_user.id
    entity.save!
    puts "Imported #{twitter_user.screen_name} - #{twitter_user.id}."
  end
end

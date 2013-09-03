namespace :bbcpeople do
  desc "Imports all the MP data into the database"
  task :import_mps => :environment do
    sql = File.open("#{Rails.root}/db/mps.sql", "r").read

    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection.execute(sql)

    puts 'Import completed.'
  end

end

BBC People
=========

The BBC people project displays profiles for various BBC personalities. 

It uses various APIs including Juicer, Nitro, Programmes and MusicBrainz to aggregate data about people and produces various feeds and information relating to that individual.

The project is hosted at http://bbcpeople.pilots.bbcconnectedstudio.co.uk/

        
## Getting Started

1. This project was developed with Ruby 2.0 and Rails 3.2.13 with Postgres for persistent storage - make sure these are installed. Using RVM is recommended.

2. Once you have ruby and rails installed, run bundler to install all required gems.

        $ bundle install
   
3. Create the config/database.yml file with the settings to access your postres db.

4. Run the migrations

        $ rake db:migrate

5. For development, use foreman, as it will startup the worker process to process delayed_job as well as setting up all the correct environment variables which you must store in a .env file. Contact Michael Smethurst for details of the environment variables.
   
   If deploying to production, you can use apache and setup the environment variables in your virtualhost. You will need to launch deplay_jobs with env vars on the commmand line. You also need to run a cron task to obtain twitter ids for twitter handles. (Again contact MS for full details of cron setup)

6. The app uses the nitro api - and can be switched between staging and production by changing the application.rb file

        config.nitro_environment = 'stage'
 

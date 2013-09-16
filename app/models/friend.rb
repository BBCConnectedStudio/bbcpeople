class Friend < ActiveRecord::Base

  attr_accessible :twitter_id

  belongs_to :user

end

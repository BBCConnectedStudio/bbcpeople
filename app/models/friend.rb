class Friend < ActiveRecord::Base

  attr_accessible :twitter_handle

  belongs_to :user

end

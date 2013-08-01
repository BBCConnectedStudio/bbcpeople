class Following < ActiveRecord::Base

  attr_accessible :user_id, :dbpedia_key

  belongs_to :user

  validates :dbpedia_key, :presence => true

end

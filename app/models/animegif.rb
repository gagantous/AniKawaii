class Animegif < ActiveRecord::Base
	validates_uniqueness_of :name
	include PgSearch
  	pg_search_scope :search_by_name, :against => :name,:using => {
                    :tsearch => {:prefix => true}
                  }

	  extend FriendlyId
  		friendly_id :name, use: :slugged
end

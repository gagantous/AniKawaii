class Animegif < ActiveRecord::Base
	validates_uniqueness_of :name
	  extend FriendlyId
  		friendly_id :name, use: :slugged
end

class GeoCountry < ActiveRecord::Base
	
	has_many	:geo_states
	
	attr_accessible :abbrev, :name

	def self.usa
		return GeoCountry.find 1
	end
	
	def code
		return self.abbrev.upcase
	end
	
end
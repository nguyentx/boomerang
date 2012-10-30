class GeoState < ActiveRecord::Base
	belongs_to :geo_country

	attr_accessible :country, :name, :abbrev
end
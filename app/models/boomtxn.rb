class Boomtxn < ActiveRecord::Base
	establish_connection "boomerang"
	set_table_name 'dbo.tblTrans'
end
# Determine which patients haven't been resupplied from BT in the last 60 days
require 'csv'
task :rescue_resupply => :environment do

=begin
	#Read in all BT patients, so we can map prior system key to BT id's
	CSV.foreach(Rails.root.join('tmp', 'input','non_va_patients.csv'), :force_quotes => true) do |row|
		puts row[3] if row[3].present?
		unless row[0].nil? || row[0].match(/Patient Last Name/) 
			patient = Patient.new
			patient.brightree_id = row[3] if row[3].present?
			patient.first_name = row[1] if row[1].present?
			patient.last_name = row[0] if row[0].present?
			patient.user4 = row[8] if row[8].present?
			patient.prior_system_key = row[9] if row[9].present?
			patient.billing_address1 = row[10] if row[10].present?
			patient.billing_address2 = row[11] if row[11].present?
			patient.billing_city = row[12] if row[12].present?
			patient.billing_geo_state_id = GeoState.find_by_abbrev( row[13] ).id if ( row[13].present? && GeoState.find_by_abbrev( row[13] ) )
			patient.billing_postal_code = row[14] if row[14].present?
			patient.billing_phone = row[15] if row[15].present?
			patient.fax = row[16] if row[16].present?
			patient.email = row[17] if row[17].present?
			patient.mobile_phone = row[18] if row[18].present?
			patient.save
		end
	end
=end

	all_patients = Array.new

	#Read in all BT patients with E0601, E0470, and E0471 HCPC sales orders
	csv_string = CSV.open("./tmp/output/patients_with_cpap_devices.csv", "wb") do |csv|
		csv << ["Brightree ID", "First Name", "Last Name", "Address 1", "Address 2", "City", "State", "Zip Code", "Phone", "Mobile Phone", "Email", "Fax", "User4"]

		CSV.foreach(Rails.root.join('tmp','input','bt_blower_sales_orders.csv')) do |row|

			unless  row[0].nil? || row[0].match(/Sales Order Number/)
				if pt = Patient.find_by_brightree_id( row[4] )
					if GeoState.find_by_id( pt.billing_geo_state_id).nil?
						state = ""
					else
						state = GeoState.find_by_id( pt.billing_geo_state_id).abbrev
					end
					csv << [pt.brightree_id, pt.first_name, pt.last_name, pt.billing_address1, pt.billing_address2, pt.billing_city, state, pt.billing_postal_code, pt.billing_phone, pt.mobile_phone, pt.email, pt.fax, pt.user4]
					all_patients << pt 
				end
			end
		end


		num_bt_patients_with_blowers = all_patients.count
		puts "BT patients with blowers #{num_bt_patients_with_blowers}"

		# Get Boom records to get all patients who have received E0470, E0471 or E0601 ever
		boom_txns = Boomtxn.where(" HCPC = 'E0471' or HCPC = 'E0470' or HCPC = 'E0601' ")

		for txn in boom_txns
			if txn.PatientID.try(:length) == 5
				psk = '00' + txn.PatientID 
			elsif txn.PatientID.try(:length) == 6
				psk = '0' + txn.PatientID
			else
				psk = '0'
			end

			pt = Patient.find_by_prior_system_key( psk )
			unless( pt.nil? || all_patients.include?( pt ) )
				all_patients << pt

				if GeoState.find_by_id( pt.billing_geo_state_id).nil?
					state = ""
				else
					state = GeoState.find_by_id( pt.billing_geo_state_id).abbrev
				end

				csv << [pt.brightree_id, pt.first_name, pt.last_name, pt.billing_address1, pt.billing_address2, pt.billing_city, state, pt.billing_postal_code, pt.billing_phone, pt.mobile_phone, pt.email, pt.fax, pt.user4]
			end
		end

		puts "Boom patients with blowers #{all_patients.count - num_bt_patients_with_blowers}"	
	end


 
	# Get Patients that have a sales order for a BT resupply in the past 60 days
	sixtyday_patients = Array.new

	csv_string = CSV.open("./tmp/output/60day_resupplied.csv", "wb") do |csv|
		csv << ["Brightree ID", "First Name", "Last Name", "Address 1", "Address 2", "City", "State", "Zip Code", "Phone", "Mobile Phone", "Email", "Fax", "User4"]
		CSV.foreach(Rails.root.join('tmp', 'input','bt_60day_resupply_sales_orders.csv'), :force_quotes => true) do |row|

			unless  row[0].nil? || row[0].match(/Sales Order Number/)
				if pt = Patient.find_by_brightree_id( row[4] )
					if GeoState.find_by_id( pt.billing_geo_state_id).nil?
						state = ""
					else
						state = GeoState.find_by_id( pt.billing_geo_state_id).abbrev
					end

					unless sixtyday_patients.include?( pt )
						sixtyday_patients << pt 
						csv << [ pt.brightree_id, pt.first_name, pt.last_name, pt.billing_address1, pt.billing_address2, pt.billing_city, state, pt.billing_postal_code, pt.billing_phone, pt.mobile_phone, pt.email, pt.fax, pt.user4]
					end
				end
			end
		end
	end

	puts "Patients resupplied in last 60 days #{sixtyday_patients.count}"	


	# Find set of patients that do not have a sales order in the past 60 days
	rescue_patients = all_patients - sixtyday_patients
	puts "Rescue patients #{rescue_patients.count}"	

	# Write out csv file with patients that don't have a sales order in the past 60 days
	csv_string = CSV.open("./tmp/output/rescue_patients.csv", "wb") do |csv|
		csv << ["Brightree ID", "First Name", "Last Name", "Address 1", "Address 2", "City", "State", "Zip Code", "Phone", "Mobile Phone", "Email", "Fax", "User4"]
		for pt in rescue_patients
			if GeoState.find_by_id( pt.billing_geo_state_id).nil?
				state = ""
			else
				state = GeoState.find_by_id( pt.billing_geo_state_id).abbrev
			end
			csv << [ pt.brightree_id, pt.first_name, pt.last_name, pt.billing_address1, pt.billing_address2, pt.billing_city, state, pt.billing_postal_code, pt.billing_phone, pt.mobile_phone, pt.email, pt.fax, pt.user4]
		end
	end


end

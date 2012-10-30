class AddPatients < ActiveRecord::Migration
	def change
		
		create_table :geo_countries do |t|
			t.string   :name
			t.string   :abbrev
			t.timestamps
		end
			
		create_table :geo_states do |t|
			t.references	:geo_country
			t.string		:name
			t.string		:abbrev
			t.string		:country
			t.timestamps
		end
		add_index :geo_states, :abbrev


		create_table :patients do |t|
			t.string		:zybex_ref_num
			t.string		:zybex_note
			t.string		:cims_ref_num
			t.string		:brightree_id
			t.string		:last_name
			t.string		:middle_name
			t.string		:first_name
			t.string		:billing_address1
			t.string		:billing_address2
			t.string		:billing_city
			t.integer		:billing_geo_state_id
			t.string		:billing_postal_code
			t.integer		:billing_geo_country_id
			t.string		:billing_phone
			t.string		:fax
			t.string		:email
			t.string		:mobile_phone
			t.string		:suffix
			t.datetime		:birthday
			t.string		:ssn
			t.string		:prior_system_key
			t.string		:account_number
			#t.references	:account_group
			t.string		:gender
			t.integer		:weight
			t.string		:height #What format does brightree take this in? inches?
			t.string		:marital_status  #married, single, other
			t.string		:employment #employed, full time student, part time student, unemployed
			t.integer		:discount_percent #integer 0 to 100
			#t.references	:branch_office
			t.boolean		:delivery_address_same_as_billing_address
			t.string		:delivery_address1
			t.string		:delivery_address2
			t.string		:delivery_city
			t.integer		:delivery_geo_state_id
			t.string		:delivery_postal_code
			t.integer		:delivery_geo_country_id
			t.string		:delivery_phone
			t.string		:user1
			t.string		:user2
			t.string		:user3
			t.string		:user4
			t.string		:pos #place of service code, default to 12
			t.integer		:ordering_doctor_id #must be validated against doctors table
			t.integer		:primary_doctor_id	#must be validated against doctors table
			t.string		:referral_type #value must be 'doctor' or 'facility'
			t.boolean		:infectious_condition, :default => 0
			t.boolean		:injury_related_to_employment, :default => 0
			t.boolean		:injury_related_to_auto_accident, :default => 0
			t.boolean		:state_of_auto_accident, :default => 0
			t.datetime		:dod #date of death
			t.string		:diag1
			t.string		:diag2
			t.string		:diag3
			t.string		:diag4
			t.string		:ec_last_name #Emergency Contact
			t.string		:ec_first_name
			t.string		:ec_middle_name
			t.string		:ec_address1
			t.string		:ec_address2
			t.string		:ec_city
			t.integer		:ec_geo_state_id
			t.string		:ec_postal_code
			t.integer		:ec_geo_country_id
			t.string		:ec_phone
			t.string		:ec_fax
			t.string		:ec_email
			t.string		:rp_last_name #Reponsible Party Contact
			t.string		:rp_first_name
			t.string		:rp_middle_name
			t.string		:rp_address1
			t.string		:rp_address2
			t.string		:rp_city
			t.integer		:rp_geo_state_id
			t.string		:rp_postal_code
			t.integer		:geo_country_id
			t.string		:rp_phone
			t.string		:rp_fax
			t.string		:rp_email
			t.boolean		:hipaa_signature_on_file, :default => 0
			#t.references	:tax_zone_id
			t.string		:county
			t.string		:marketing_rep
			t.string		:practitioner
			t.string		:claim_code
			t.string		:type_code
			t.string		:customer_type
			t.string		:facility
			t.string		:rendering_provider_type
			t.string		:rendering_provider_key
			t.string		:custom1
			t.string		:custom2
			t.string		:custom3
			t.string		:custom4
			t.string		:custom5
			t.string		:custom6
			t.string		:custom7
			t.string		:custom8
			t.string		:custom9
			t.string		:custom10
			t.string		:raw_system_key
			t.string		:referral_entity_id
			t.boolean		:active  
		end
	end

end

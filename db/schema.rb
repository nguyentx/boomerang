# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121017162429) do

  create_table "geo_countries", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "geo_states", :force => true do |t|
    t.integer  "geo_country_id"
    t.string   "name"
    t.string   "abbrev"
    t.string   "country"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "geo_states", ["abbrev"], :name => "index_geo_states_on_abbrev"

  create_table "patients", :force => true do |t|
    t.string   "zybex_ref_num"
    t.string   "zybex_note"
    t.string   "cims_ref_num"
    t.string   "brightree_id"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "first_name"
    t.string   "billing_address1"
    t.string   "billing_address2"
    t.string   "billing_city"
    t.integer  "billing_geo_state_id"
    t.string   "billing_postal_code"
    t.integer  "billing_geo_country_id"
    t.string   "billing_phone"
    t.string   "fax"
    t.string   "email"
    t.string   "mobile_phone"
    t.string   "suffix"
    t.datetime "birthday"
    t.string   "ssn"
    t.string   "prior_system_key"
    t.string   "account_number"
    t.string   "gender"
    t.integer  "weight"
    t.string   "height"
    t.string   "marital_status"
    t.string   "employment"
    t.integer  "discount_percent"
    t.boolean  "delivery_address_same_as_billing_address"
    t.string   "delivery_address1"
    t.string   "delivery_address2"
    t.string   "delivery_city"
    t.integer  "delivery_geo_state_id"
    t.string   "delivery_postal_code"
    t.integer  "delivery_geo_country_id"
    t.string   "delivery_phone"
    t.string   "user1"
    t.string   "user2"
    t.string   "user3"
    t.string   "user4"
    t.string   "pos"
    t.integer  "ordering_doctor_id"
    t.integer  "primary_doctor_id"
    t.string   "referral_type"
    t.boolean  "infectious_condition",                     :default => false
    t.boolean  "injury_related_to_employment",             :default => false
    t.boolean  "injury_related_to_auto_accident",          :default => false
    t.boolean  "state_of_auto_accident",                   :default => false
    t.datetime "dod"
    t.string   "diag1"
    t.string   "diag2"
    t.string   "diag3"
    t.string   "diag4"
    t.string   "ec_last_name"
    t.string   "ec_first_name"
    t.string   "ec_middle_name"
    t.string   "ec_address1"
    t.string   "ec_address2"
    t.string   "ec_city"
    t.integer  "ec_geo_state_id"
    t.string   "ec_postal_code"
    t.integer  "ec_geo_country_id"
    t.string   "ec_phone"
    t.string   "ec_fax"
    t.string   "ec_email"
    t.string   "rp_last_name"
    t.string   "rp_first_name"
    t.string   "rp_middle_name"
    t.string   "rp_address1"
    t.string   "rp_address2"
    t.string   "rp_city"
    t.integer  "rp_geo_state_id"
    t.string   "rp_postal_code"
    t.integer  "geo_country_id"
    t.string   "rp_phone"
    t.string   "rp_fax"
    t.string   "rp_email"
    t.boolean  "hipaa_signature_on_file",                  :default => false
    t.string   "county"
    t.string   "marketing_rep"
    t.string   "practitioner"
    t.string   "claim_code"
    t.string   "type_code"
    t.string   "customer_type"
    t.string   "facility"
    t.string   "rendering_provider_type"
    t.string   "rendering_provider_key"
    t.string   "custom1"
    t.string   "custom2"
    t.string   "custom3"
    t.string   "custom4"
    t.string   "custom5"
    t.string   "custom6"
    t.string   "custom7"
    t.string   "custom8"
    t.string   "custom9"
    t.string   "custom10"
    t.string   "raw_system_key"
    t.string   "referral_entity_id"
    t.boolean  "active"
  end

  add_index "patients", ["brightree_id"], :name => "index_patients_on_brightree_id"
  add_index "patients", ["prior_system_key"], :name => "index_patients_on_prior_system_key"

  create_table "sales_orders", :force => true do |t|
    t.string   "brightree_num"
    t.string   "create_date"
    t.string   "created_by"
    t.datetime "confirm_date"
    t.string   "brightree_patient_id"
    t.string   "proc_code"
    t.string   "misc"
  end

  add_index "sales_orders", ["brightree_num"], :name => "index_sales_orders_on_brightree_num"
  add_index "sales_orders", ["brightree_patient_id"], :name => "index_sales_orders_on_brightree_patient_id"

end

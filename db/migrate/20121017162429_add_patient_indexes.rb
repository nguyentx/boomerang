class AddPatientIndexes < ActiveRecord::Migration
  def change
  	add_index :patients, :prior_system_key
  	add_index :patients, :brightree_id
  end


end

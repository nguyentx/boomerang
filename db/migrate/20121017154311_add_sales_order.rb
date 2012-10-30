class AddSalesOrder < ActiveRecord::Migration
  def change
		create_table :sales_orders do |t|
			t.string 	:brightree_num
			t.string 	:create_date
			t.string 	:created_by
			t.datetime 	:confirm_date
			t.string	:brightree_patient_id
			t.string	:proc_code
			t.string	:misc
		end
		add_index :sales_orders, :brightree_num
		add_index :sales_orders, :brightree_patient_id
  end


end

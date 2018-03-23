class AddColumnPincodeToCitizens < ActiveRecord::Migration[5.1]
  def change
  	add_column :citizens,:pincode,:string
  end
end

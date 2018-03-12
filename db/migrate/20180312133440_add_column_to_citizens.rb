class AddColumnToCitizens < ActiveRecord::Migration[5.1]
  def change
  	add_column :citizens, :first_name, :string, :presence => true
    add_column :citizens, :last_name, :string, :presence => true
    add_column :citizens, :mobile, :string, :presence => true
    add_column :citizens, :aadhar_no, :string, :presence => true
    add_column :citizens, :dob, :date, :presence => true
    add_column :citizens, :address, :text, :presence => true
  end
end

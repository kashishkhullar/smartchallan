class AddColumnToTrafficpolices < ActiveRecord::Migration[5.1]
  def change
  	add_column :trafficpolices, :first_name, :string
    add_column :trafficpolices, :last_name, :string
    add_column :trafficpolices, :mobile, :string
    add_column :trafficpolices, :aadhar_no, :string
    add_column :trafficpolices, :dob, :date
    add_column :trafficpolices, :address, :text
    add_column :trafficpolices, :police_key, :string, :presence => true
    add_column :trafficpolices, :registered, :boolean, :default=> false

  end
end

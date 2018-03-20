class AddColumnsToCommercials < ActiveRecord::Migration[5.1]
  def change
    add_column :commercials, :identification_no, :string
    add_column :commercials, :company_name, :string
    add_column :commercials, :owner_name, :string
    add_column :commercials, :address, :text
    add_column :commercials, :mobile, :string
    add_column :commercials, :phone_no, :string
  end
end

class RenameColumnInCitizens < ActiveRecord::Migration[5.1]
  def change
  	add_column :citizens, :dlnumber, :string
  end
end

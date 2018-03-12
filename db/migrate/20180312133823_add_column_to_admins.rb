class AddColumnToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :mobile, :string
    add_column :admins, :admin_key, :string, :presence => true
  end
end

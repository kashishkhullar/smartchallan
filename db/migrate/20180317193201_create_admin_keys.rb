class CreateAdminKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_keys do |t|
      t.string :admin_key
      t.timestamps
    end
  end
end

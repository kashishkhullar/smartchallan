class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :category
      t.date :dop
      t.string :registration_no
      t.references :citizen, index: true,foreign_key: true

      t.timestamps
    end
  end
end

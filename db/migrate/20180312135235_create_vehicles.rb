class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :type
      t.date :dop
      t.string :registration_no
      t.references :citizen, foreign_key: true

      t.timestamps
    end
  end
end

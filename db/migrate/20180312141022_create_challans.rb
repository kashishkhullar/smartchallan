class CreateChallans < ActiveRecord::Migration[5.1]
  def change
    create_table :challans do |t|
      t.references :challantype, index: true,foreign_key: true
      t.date :date_of_issue
      t.time :time_of_issue
      t.decimal :latitude
      t.decimal :longitude
      t.text :address
      t.references :vehicle,index: true,foreign_key: true
      t.references :trafficpolice, index: true,foreign_key: true
      t.references :citizen, index: true,foreign_key: true
      t.date :due_date

      t.timestamps
    end
  end
end

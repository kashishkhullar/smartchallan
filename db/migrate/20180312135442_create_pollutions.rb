class CreatePollutions < ActiveRecord::Migration[5.1]
  def change
    create_table :pollutions do |t|
      t.string :pollution_no
      t.date :date_of_issue
      t.date :date_of_expiry
      t.text :place_of_issue
      t.references :vehicle,index: true, foreign_key: true
      t.references :citizen, index: true,foreign_key: true

      t.timestamps
    end
  end
end

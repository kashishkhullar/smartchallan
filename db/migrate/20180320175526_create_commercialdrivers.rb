class CreateCommercialdrivers < ActiveRecord::Migration[5.1]
  def change
    create_table :commercialdrivers do |t|
      t.references :commercials, index: true, foreign_key: true
      t.references :citizens,index: true, foreign_key: true
      t.references :vehicle, index: true,foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end

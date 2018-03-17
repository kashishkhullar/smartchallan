class CreateTrafficpoliceKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :trafficpolice_keys do |t|
      t.string :trafficpolice_key
      t.timestamps
    end
  end
end

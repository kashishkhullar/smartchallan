class CreateChallanTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :challan_types do |t|
      t.string :type
      t.decimal :amount
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end

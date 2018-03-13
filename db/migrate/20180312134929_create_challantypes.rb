class CreateChallantypes < ActiveRecord::Migration[5.1]
  def change
    create_table :challantypes do |t|
      t.string :name
      t.decimal :amount
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end

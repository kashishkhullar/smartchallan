class AddColumnToChallans < ActiveRecord::Migration[5.1]
  def change
  	add_column :challans,:paid,:boolean, default: :false
  end
end

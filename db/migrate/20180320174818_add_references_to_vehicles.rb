class AddReferencesToVehicles < ActiveRecord::Migration[5.1]
  def change
  	  	add_reference :vehicles, :commercial, index: true
  end
end

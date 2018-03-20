class AddReferencesToCitizens < ActiveRecord::Migration[5.1]
  def change
  	  	add_reference :citizens, :commercial, index: true
  end
end

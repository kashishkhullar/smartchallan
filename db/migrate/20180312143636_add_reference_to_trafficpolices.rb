class AddReferenceToTrafficpolices < ActiveRecord::Migration[5.1]
  def change
  	add_reference :trafficpolices, :admin, index: true
  end
end

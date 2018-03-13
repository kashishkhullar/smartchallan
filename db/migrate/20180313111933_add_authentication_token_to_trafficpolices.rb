class AddAuthenticationTokenToTrafficpolices < ActiveRecord::Migration[5.1]
  def change
    add_column :trafficpolices, :authentication_token, :string, limit: 30
    add_index :trafficpolices, :authentication_token, unique: true
  end
end

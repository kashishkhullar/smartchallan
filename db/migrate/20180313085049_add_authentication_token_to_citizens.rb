class AddAuthenticationTokenToCitizens < ActiveRecord::Migration[5.1]
  def change
    add_column :citizens, :authentication_token, :string, limit: 30
    add_index :citizens, :authentication_token, unique: true
  end
end

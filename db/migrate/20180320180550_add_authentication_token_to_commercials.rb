class AddAuthenticationTokenToCommercials < ActiveRecord::Migration[5.1]
  def change
    add_column :commercials, :authentication_token, :string, limit: 30
    add_index :commercials, :authentication_token, unique: true
  end
end

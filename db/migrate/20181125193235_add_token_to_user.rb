class AddTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string, unique: true
  end
end

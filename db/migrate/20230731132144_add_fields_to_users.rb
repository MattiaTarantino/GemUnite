class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, null: false, unique: true, default: ""
    add_column :users, :firstname, :string, null: false, default: ""
    add_column :users, :lastname, :string, null: false, default: ""
  end
end

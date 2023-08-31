class RenameUtentesToUsers < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :utentes, :users
  end

  def self.down
    rename_table :utentes, :users
  end
end

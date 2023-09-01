class AddUniqueConstraintFieldUser < ActiveRecord::Migration[7.0]
  def change
    add_index :fields, :nome, unique: true
    add_index :users, :username, unique: true
  end
end

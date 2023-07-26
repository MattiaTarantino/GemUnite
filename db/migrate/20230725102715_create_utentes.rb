class CreateUtentes < ActiveRecord::Migration[7.0]
  def change
    create_table :utentes do |t|
      t.string :username
      t.string :nome
      t.string :cognome
      t.string :password
      t.string :mail

      t.timestamps
    end
  end
end

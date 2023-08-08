class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :nome
      t.string :descrizione
      t.string :completato

      t.timestamps
    end
  end
end

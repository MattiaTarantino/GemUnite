class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :id_progetto
      t.string :info_leader
      t.string :dimensione
      t.string :descrizione
      t.string :stato

      t.timestamps
    end
  end


end

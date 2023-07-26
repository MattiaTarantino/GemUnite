class CreateProgettos < ActiveRecord::Migration[7.0]
  def change
    create_table :progettos do |t|
      t.string :id_progetto
      t.string :info_leader
      t.string :dimensione
      t.string :descrizione
      t.string :stato

      t.timestamps
    end
  end
end

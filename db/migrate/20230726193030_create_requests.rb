class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :request_id
      t.string :note
      t.string :stato_accettazione
      t.references 'progetto'
      t.references 'utente'
      t.timestamps
    end
  end
end

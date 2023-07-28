class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :descrizione

      t.timestamps
    end
  end
end

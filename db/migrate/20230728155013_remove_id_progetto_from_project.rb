class RemoveIdProgettoFromProject < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :id_progetto, :string
  end
end

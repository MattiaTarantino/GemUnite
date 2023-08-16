class ChangeCompletatoType < ActiveRecord::Migration[7.0]
  def change
    change_column :checkpoints, :completato, :boolean, default: false
    change_column :tasks, :completato, :boolean, default: false
  end
end

class RenameProgettosToProjects < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :progettos, :projects
  end

  def self.down
    rename_table :progettos, :projects
  end
end

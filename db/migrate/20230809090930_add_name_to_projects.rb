class AddNameToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :name, :string, null: false
  end
end

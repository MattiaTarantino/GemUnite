class AddDefaultToProjects < ActiveRecord::Migration[7.0]
  def change
    change_column_default :projects, :stato, from: nil, to: "aperto"
  end
end

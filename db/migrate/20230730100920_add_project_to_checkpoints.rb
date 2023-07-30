class AddProjectToCheckpoints < ActiveRecord::Migration[7.0]
  def change
    add_reference :checkpoints, :project, null: false, foreign_key: true
  end
end

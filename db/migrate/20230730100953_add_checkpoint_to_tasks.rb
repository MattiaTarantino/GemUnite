class AddCheckpointToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :checkpoint, null: false, foreign_key: true
  end
end

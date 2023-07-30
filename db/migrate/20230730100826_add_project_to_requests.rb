class AddProjectToRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :requests, :project, null: false, foreign_key: true
  end
end

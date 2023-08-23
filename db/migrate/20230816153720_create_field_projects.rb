class CreateFieldProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :field_projects do |t|

      t.timestamps
    end
  end
end

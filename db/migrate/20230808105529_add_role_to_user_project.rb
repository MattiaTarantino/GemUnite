class AddRoleToUserProject < ActiveRecord::Migration[7.0]
  def change
    add_column :user_projects, :role, :string, null: false, default: "member"
  end
end

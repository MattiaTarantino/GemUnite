class UpdateForeignKeyAddOnDeleteConstraint < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :user_projects, :users
    add_foreign_key :user_projects, :users, on_delete: :cascade

    remove_foreign_key :user_projects, :projects
    add_foreign_key :user_projects, :projects, on_delete: :cascade

    remove_foreign_key :requests, :projects
    add_foreign_key :requests, :projects, on_delete: :cascade

    remove_foreign_key :requests, :users
    add_foreign_key :requests, :users, on_delete: :cascade

    add_foreign_key :fields_projects, :fields, on_delete: :cascade
    add_foreign_key :fields_projects, :projects, on_delete: :cascade

    add_foreign_key :fields_users, :fields, on_delete: :cascade
    add_foreign_key :fields_users, :users, on_delete: :cascade
  end
end

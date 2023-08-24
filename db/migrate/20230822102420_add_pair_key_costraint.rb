class AddPairKeyCostraint < ActiveRecord::Migration[7.0]
  def changes
    add_index :fields_projects, [:project_id, :field_id], unique: true
    add_index :user_projects, [:user_id, :project_id], unique: true
    add_index :user_chats, [:user_id, :chat_id], unique: true
  end
end

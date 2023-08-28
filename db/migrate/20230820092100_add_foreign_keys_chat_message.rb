class AddForeignKeysChatMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :user_id, :bigint, null: false
    add_column :messages, :chat_id, :bigint, null: false
    add_column :chats, :project_id, :bigint, null: false
    add_foreign_key :messages, :users, column: :user_id
    add_foreign_key :messages, :chats, column: :chat_id
    add_foreign_key :chats, :projects, column: :project_id
  end
end

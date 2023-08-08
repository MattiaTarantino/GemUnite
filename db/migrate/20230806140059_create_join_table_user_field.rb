class CreateJoinTableUserField < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :fields do |t|
      t.index [:user_id, :field_id]
      # t.index [:field_id, :user_id]
    end
  end
end

class RemoveRequestIdFromRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :request_id, :string
  end
end

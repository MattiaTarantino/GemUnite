class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "project_id", "role", "updated_at", "user_id"]
  end
end

class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates_presence_of :role
  validates_presence_of :project
  validates_presence_of :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "project_id", "role", "updated_at", "user_id"]
  end
end

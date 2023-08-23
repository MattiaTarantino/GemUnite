class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :project

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "project_id", "updated_at"]
  end
end

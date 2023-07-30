class Request < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "note", "stato_accettazione", "updated_at"]
  end
end

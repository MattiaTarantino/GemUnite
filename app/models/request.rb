class Request < ApplicationRecord
  belongs_to :progetto
  belongs_to :utente
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "note", "request_id", "stato_accettazione", "updated_at"]
  end
end

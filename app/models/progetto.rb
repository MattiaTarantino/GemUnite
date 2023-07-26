class Progetto < ApplicationRecord
    
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descrizione", "dimensione", "id", "id_progetto", "info_leader", "stato", "updated_at"]
  end
end

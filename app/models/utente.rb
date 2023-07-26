class Utente < ApplicationRecord
  has_many :requests
  def self.ransackable_attributes(auth_object = nil)
      ["cognome", "created_at", "id", "mail", "nome", "password", "updated_at", "username"]
  end
end

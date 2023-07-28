class User < ApplicationRecord
  has_many :requests
  def self.ransackable_attributes(auth_object = nil)
      ["cognome", "created_at", "id", "mail", "nome", "password", "updated_at", "username"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["requests"]
  end
end

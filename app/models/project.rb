class Project < ApplicationRecord
  has_many :requests
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descrizione", "dimensione", "id", "info_leader", "stato", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["requests"]
  end
end

class Project < ApplicationRecord
  has_many :requests
  has_many :users, through: :requests
  has_many :checkpoints
  has_many :tasks, through: :checkpoints
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descrizione", "dimensione", "id", "info_leader", "stato", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["requests"]
  end
end

class Project < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_and_belongs_to_many :users
  has_many :checkpoints, dependent: :destroy
  has_many :tasks, through: :checkpoints
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descrizione", "dimensione", "id", "info_leader", "stato", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["requests"]
  end
end

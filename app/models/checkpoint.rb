class Checkpoint < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["completato", "created_at", "descrizione", "id", "nome", "project_id", "updated_at"]
  end
end

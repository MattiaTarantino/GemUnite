class Checkpoint < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy

  validate :custom_validations

  validates_presence_of :project

  private

  def custom_validations
    validate_presence_and_format(:nome)
    validate_presence_and_format(:descrizione)
  end



  def self.ransackable_attributes(auth_object = nil)
    ["completato", "created_at", "descrizione", "id", "nome", "project_id", "updated_at"]
  end
end

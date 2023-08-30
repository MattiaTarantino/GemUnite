class Request < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates_presence_of :note, :stato_accettazione
  validates_presence_of :project
  validates_presence_of :user
  validate :custom_validations

  def custom_validations
    validate_presence_and_format(:note)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "note", "stato_accettazione", "updated_at"]
  end
end

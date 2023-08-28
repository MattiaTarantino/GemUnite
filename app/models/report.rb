class Report < ApplicationRecord
  belongs_to :user
  validates :descrizione, presence: true
  validate :custom_validations

  def custom_validations
    validate_presence_and_format(:descrizione)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descrizione", "id", "updated_at", "user_id"]
  end
end

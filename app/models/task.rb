class Task < ApplicationRecord
  belongs_to :checkpoint
  validates :nome, presence: true
  validates :descrizione, presence: true
  validates_presence_of :checkpoint

  validate :custom_validations

  def custom_validations
    validate_presence_and_format(:nome)
    validate_presence_and_format(:descrizione)
  end
end

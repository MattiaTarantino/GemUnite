class Task < ApplicationRecord
  belongs_to :checkpoint
  validates :nome, presence: true
  validates :descrizione, presence: true
end

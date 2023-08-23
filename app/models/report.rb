class Report < ApplicationRecord
  belongs_to :user
  validates :descrizione, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descrizione", "id", "updated_at", "user_id"]
  end
end

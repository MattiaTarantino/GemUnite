class Field < ApplicationRecord

  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects

  validates :nome, presence: true, uniqueness: true
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "nome", "updated_at"]
  end
end

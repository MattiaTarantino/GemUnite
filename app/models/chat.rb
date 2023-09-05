class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :project

  validates_presence_of :project

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "project_id", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["messages", "project"]
  end
end

class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :content, presence: true
  validates_presence_of :chat
  validates_presence_of :user
  validate :custom_validations

  def custom_validations
    validate_presence_and_format(:content)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "content", "user_id", "chat_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["chat", "user"]
  end
end

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
end

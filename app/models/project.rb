class Project < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :checkpoints, dependent: :destroy
  has_many :tasks, through: :checkpoints
  has_one :chat, dependent: :destroy  # check it
  has_and_belongs_to_many :fields

  validates :descrizione, presence: true
  validates :dimensione, presence: true
  validates :info_leader, presence: true
  validates :name, presence: true
  # validates_presence_of :fields
  validate :custom_validations

  def custom_validations
    validate_presence_and_format(:name)
    validate_presence_and_format(:descrizione)
    validate_presence_and_format(:info_leader)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descrizione", "dimensione", "id", "info_leader", "stato", "updated_at", "name"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["requests", "user_projects", "users", "checkpoints", "tasks", "chat", "fields"]
  end
end

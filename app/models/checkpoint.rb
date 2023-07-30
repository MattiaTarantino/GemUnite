class Checkpoint < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy # questo credo sia on delete cascade
end

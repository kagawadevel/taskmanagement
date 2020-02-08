class Label < ApplicationRecord

  validates :title, presence: true

  belongs_to :user
  has_many :task_labels
  has_many :tasks, through: :task_labels, source: :task
end

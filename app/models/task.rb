class Task < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  enum priority: {'高':0,'中':1,'低':2}

  scope :sort_expired_asc, -> {order(limit: :asc)}
  scope :sort_priority_asc, -> {order(priority: :asc)}
  scope :title_search, -> (title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status) { where(status: status)}
  scope :currentuser_task, -> (current_user_id){ where(user_id: current_user_id) }

  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label


end
